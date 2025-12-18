import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/connector_types.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/base/presentation/widgets/icon_checkbox.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  bool ac = false;
  bool dc = false;
  bool less_than_60 = false;
  bool value_60 = false;
  bool more_than_60 = false;

  List<String> selectedConnectors = [];

  // CONNECTOR LOGIC
  bool _isConnectorEnabled(String name) {
    if (ac && !dc) {
      return name == "Type 1" || name == "Type 2";
    }

    if (dc && !ac) {
      return name != "Type 1" && name != "Type 2";
    }

    return true;
  }

  // POWER LOGIC ✔
  bool _isPowerEnabled(String label) {
    if (ac && !dc) {
      return label == "Less than 60 kW"; // ONLY this one enabled
    }
    return true;
  }
  
  // AUTO CLEAN POWER WHEN AC SELECTED 
  void _cleanPowerSelectionForAC() {
    if (ac && !dc) {
      value_60 = false;
      more_than_60 = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Container(
      padding: EdgeInsets.only(bottom: screenHeight * 0.04),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenWidth * 0.045),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        ac =
                            dc = less_than_60 = value_60 = more_than_60 = false;
                        selectedConnectors.clear();
                      });
                    },
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        color: AppColors.tealColor,
                        fontWeight: FontWeight.w900,
                        fontSize: screenWidth * 0.038,
                      ),
                    ),
                  ),
                  Text(
                    "Filter Charges",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: screenWidth * 0.06),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            Divider(thickness: 1, color: AppColors.netural100Color),

            // CHARGE TYPE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Charge Type',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // AC
                  IconCheckbox(
                    label: "AC",
                    value: ac,
                    onChanged: (v) {
                      setState(() {
                        ac = v;

                        // AUTO-CLEAR POWER VALUES
                        _cleanPowerSelectionForAC();

                        if (ac && !dc) {
                          selectedConnectors.removeWhere(
                            (item) => item != "Type 1" && item != "Type 2",
                          );
                        }
                      });
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),

                  // DC
                  IconCheckbox(
                    label: "DC",
                    value: dc,
                    onChanged: (v) {
                      setState(() {
                        dc = v;

                        if (dc && !ac) {
                          selectedConnectors.removeWhere(
                            (item) => item == "Type 1" || item == "Type 2",
                          );
                        }
                      });
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),

                  SizedBox(height: screenHeight * 0.025),

                  // POWER SECTION ✔ FULLY UPDATED
                  Text(
                    'Power',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // LESS THAN 60 – ALWAYS CLICKABLE WHEN AC
                  IconCheckbox(
                    label: "Less than 60 kW",
                    value: less_than_60,
                    enabled: _isPowerEnabled("Less than 60 kW"),
                    onChanged: (v) => setState(() => less_than_60 = v),
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),

                  // 60 kW – DIMMED + DISABLED WHEN AC
                  Opacity(
                    opacity: _isPowerEnabled("60 kW") ? 1.0 : 0.35,
                    child: IconCheckbox(
                      label: "60 kW",
                      value: value_60,
                      enabled: _isPowerEnabled("60 kW"),
                      onChanged: (v) => setState(() => value_60 = v),
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                  ),

                  // MORE THAN 60 – DIMMED + DISABLED WHEN AC
                  Opacity(
                    opacity: _isPowerEnabled("More than 60 kW") ? 1.0 : 0.35,
                    child: IconCheckbox(
                      label: "More than 60 kW",
                      value: more_than_60,
                      enabled: _isPowerEnabled("More than 60 kW"),
                      onChanged: (v) => setState(() => more_than_60 = v),
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.025),

                  // CONNECTORS
                  Text(
                    'Connector Type',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  Wrap(
                    spacing: screenWidth * 0.025,
                    runSpacing: screenWidth * 0.025,
                    children:
                        connectorTypes.map((c) {
                          final String name = c['name'];
                          final bool selected = selectedConnectors.contains(
                            name,
                          );
                          final bool enabled = _isConnectorEnabled(name);

                          return GestureDetector(
                            onTap:
                                enabled
                                    ? () {
                                      setState(() {
                                        selected
                                            ? selectedConnectors.remove(name)
                                            : selectedConnectors.add(name);
                                      });
                                    }
                                    : null,
                            child: Opacity(
                              opacity: enabled ? 1.0 : 0.35,
                              child: Container(
                                width: (screenWidth - screenWidth * 0.18) / 4,
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.012,
                                ),
                                decoration: BoxDecoration(
                                  color: selected ? null : AppColors.whiteColor,
                                  border: Border.all(
                                    color:
                                        selected
                                            ? AppColors.tealColor
                                            : AppColors.neutral200Color,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.025,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      c['icon'],
                                      width: screenWidth * 0.08,
                                      height: screenWidth * 0.08,
                                    ),
                                    SizedBox(height: screenHeight * 0.007),
                                    Text(
                                      name,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.03,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.035),

            // APPLY BUTTON
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.065,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tealColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Apply',
                    style: TextStyle(
                      fontSize: screenWidth * 0.042,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
