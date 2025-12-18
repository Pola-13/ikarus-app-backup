import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/wallet_management/presentation/widgets/receipt/dashedline.dart';
import 'package:ikarusapp/features/wallet_management/presentation/widgets/receipt/download_receipt_button.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:flutter/rendering.dart';

class ViewReceipt extends StatefulWidget {
  const ViewReceipt({super.key});

  @override
  State<ViewReceipt> createState() => _ViewReceiptState();
}

class _ViewReceiptState extends State<ViewReceipt> {
  final GlobalKey _receiptKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: buildAppBar(context, "View Receipt"),

        body: RepaintBoundary(
          key: _receiptKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),

                // LOGO
                Row(
                  children: [
                    Image.asset(
                      "assets/logo/greenlogo.png",
                      width: screenWidth * 0.4,
                    ),
                    SizedBox(width: screenWidth * 0.03),
                  ],
                ),

                SizedBox(height: screenHeight * 0.02),

                // RECEIPT INFORMATION
                _infoRow("Receipt No:", "RCPT-2025-0831-0142"),
                _infoRow("Issue Date:", "7 Aug 2025, 10:12 PM"),
                _infoRow("Customer:", "Ahmed Mohamed"),

                SizedBox(height: screenHeight * 0.01),

                DashedLine(
                  height: 1,
                  dashWidth: 9,
                  dashSpace: 9,
                  color: AppColors.netural400Color,
                ),

                SizedBox(height: screenHeight * 0.015),

                // LOCATION
                Text(
                  "Location",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                _infoRow("Station:", "Zahraa Almaadai"),
                _infoRow("Address:", "55 Zahraa Almaadai, Cairo 78239"),
                _infoRow("Charger:", "AC 22 KW Zahraa Almaadai 1 (1)"),
                _infoRow("Session:", "ID SES-7A25-42K"),

                SizedBox(height: screenHeight * 0.01),

                DashedLine(
                  height: 1,
                  dashWidth: 9,
                  dashSpace: 9,
                  color: AppColors.netural400Color,
                ),
                SizedBox(height: screenHeight * 0.015),

                // CHARGING DETAILS
                Text(
                  "Charging Details",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                _infoRow("Start In:", "7 Aug 2025, 10:12 PM"),
                _infoRow("End In:", "7 Aug 2025, 11:12 PM"),
                _infoRow("Duration:", "01:12:56"),
                _unitRow("Energy Delivered:", "42.00", "KWh"),
                _unitRow("Idle Fees:", "12", "EGP"),
                _totalRow(context, "Total", "206.39", "EGP"),

                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),

        // DOWNLOAD BUTTON CALLING PDF FUNCTION
        bottomNavigationBar: DownloadReceiptButton(
          onPressed: () async {
            await _downloadReceiptAsPDF();
          },
        ),
      ),
    );
  }

  // PDF GENERATION FUNCTION
Future<void> _downloadReceiptAsPDF() async {
  try {
    // Ask permission
    await Permission.storage.request();

    // Capture widget
    RenderRepaintBoundary boundary =
        _receiptKey.currentContext!.findRenderObject()
            as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final pdf = pw.Document();
    final pdfImage = pw.MemoryImage(pngBytes);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(child: pw.Image(pdfImage));
        },
      ),
    );

    final pdfBytes = await pdf.save();

    // Get Downloads folder
    Directory? downloadsDir;

    if (Platform.isAndroid) {
      downloadsDir = Directory("/storage/emulated/0/Download");
    } else {
      downloadsDir = await getDownloadsDirectory();
    }

    final filePath = "${downloadsDir!.path}/ikarus_receipt.pdf";
    final file = File(filePath);

    await file.writeAsBytes(pdfBytes);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PDF downloaded to ${file.path}")),
    );

    print("PDF saved at: $filePath");

  } catch (e) {
    print("PDF DOWNLOAD ERROR: $e");
  }
}


  // INFO ROWS
  Widget _infoRow(String title, String value) {
    final double screenWidth = Device.deviceWidth(context: context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _unitRow(String title, String number, String unit) {
    final double screenWidth = Device.deviceWidth(context: context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: number,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                  ),
                ),
                TextSpan(
                  text: " $unit",
                  style: TextStyle(
                    fontSize: screenWidth * 0.038,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalRow(
    BuildContext context,
    String title,
    String number,
    String unit,
  ) {
    final double screenWidth = Device.deviceWidth(context: context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: number,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                TextSpan(
                  text: " $unit",
                  style: TextStyle(
                    fontSize: screenWidth * 0.040,
                    fontWeight: FontWeight.w600,
                    color: AppColors.netural600Color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
