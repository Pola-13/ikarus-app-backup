import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ikarusapp/core/constants/device.dart';

class SocialIcon extends StatelessWidget {
  final String imagePath;
  final String url;

  const SocialIcon({
    super.key,
    required this.imagePath,
    required this.url,
  });

  Future<void> _launchUrl(BuildContext context) async {
    final Uri uri = Uri.parse(url);

    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error launching URL: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), 
      child: GestureDetector(
        onTap: () => _launchUrl(context),
        child: CircleAvatar(
          radius: screenWidth * 0.07,
          backgroundColor:  Color(0XFFE7EDEE),
          backgroundImage: AssetImage(imagePath),
        ),
      ),
    );
  }
}
