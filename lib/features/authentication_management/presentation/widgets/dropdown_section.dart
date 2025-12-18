import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/injection/location_injection.dart';
import 'package:ikarusapp/features/base/presentation/widgets/dropdowmmenu.dart';

class DropdownSection extends ConsumerStatefulWidget {
  final String? countryError;
  final String? cityError;
  final String? streetError;

  final ValueChanged<String?> onCountryChanged;
  final ValueChanged<String?> onGovernorateChanged;
  final ValueChanged<String?> onDistrictChanged;

  const DropdownSection({
    super.key,
    this.countryError,
    this.cityError,
    this.streetError,
    required this.onCountryChanged,
    required this.onGovernorateChanged,
    required this.onDistrictChanged,
  });

  @override
  ConsumerState<DropdownSection> createState() => _DropdownSectionState();
}

class _DropdownSectionState extends ConsumerState<DropdownSection> {
  @override
  void initState() {
    super.initState();
    // Load countries when widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationViewModelProvider.notifier).loadCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);
    
    final locationState = ref.watch(locationViewModelProvider);
    final locationNotifier = ref.read(locationViewModelProvider.notifier);

    return Column(
      children: [
        // Country Dropdown
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownField(
              label: "Country",
              hint: "Select Country",
              value: locationState.selectedCountryCode != null &&
                      locationState.countries.any((c) => c.code == locationState.selectedCountryCode)
                  ? locationState.selectedCountryCode
                  : null,
              items: locationState.isLoadingCountries
                  ? [
                      const DropdownMenuItem(
                        value: null,
                        child: Center(
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.tealColor),
                            ),
                          ),
                        ),
                      )
                    ]
                  : locationState.countries
                      .map((country) => DropdownMenuItem(
                            value: country.code,
                            child: Text(country.name),
                          ))
                      .toList(),
              onChanged: locationState.isLoadingCountries
                  ? (_) {}
                  : (value) {
                      locationNotifier.selectCountry(value);
                      widget.onCountryChanged(value);
                    },
            ),
            if (widget.countryError != null)
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  top: screenHeight * 0.005,
                ),
                child: Text(
                  widget.countryError!,
                  style: TextStyle(
                    color: AppColors.statusRedColor,
                    fontSize: screenWidth * 0.032,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
              ),
            if (locationState.countriesError != null)
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  top: screenHeight * 0.005,
                ),
                child: Text(
                  locationState.countriesError!,
                  style: TextStyle(
                    color: AppColors.statusRedColor,
                    fontSize: screenWidth * 0.032,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 15),

        // Governorate (City) Dropdown
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownField(
              label: "Governorate",
              hint: "Select Governorate",
              value: locationState.selectedCityId != null &&
                      locationState.cities.any((c) => c.id == locationState.selectedCityId)
                  ? locationState.selectedCityId
                  : null,
              items: locationState.selectedCountryCode == null
                  ? []
                  : locationState.isLoadingCities
                      ? [
                          const DropdownMenuItem(
                            value: null,
                            child: Center(
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.tealColor),
                                ),
                              ),
                            ),
                          )
                        ]
                      : locationState.cities
                          .map((city) => DropdownMenuItem(
                                value: city.id,
                                child: Text(city.name),
                              ))
                          .toList(),
              onChanged: locationState.selectedCountryCode == null ||
                      locationState.isLoadingCities
                  ? (_) {}
                  : (value) {
                      locationNotifier.selectCity(value);
                      widget.onGovernorateChanged(value);
                    },
            ),
            if (widget.cityError != null)
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  top: screenHeight * 0.005,
                ),
                child: Text(
                  widget.cityError!,
                  style: TextStyle(
                    color: AppColors.statusRedColor,
                    fontSize: screenWidth * 0.032,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
              ),
            if (locationState.citiesError != null)
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  top: screenHeight * 0.005,
                ),
                child: Text(
                  locationState.citiesError!,
                  style: TextStyle(
                    color: AppColors.statusRedColor,
                    fontSize: screenWidth * 0.032,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 15),

        // District Dropdown
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownField(
              label: "District",
              hint: "Select District",
              value: locationState.selectedDistrictId != null &&
                      locationState.districts.any((d) => d.id == locationState.selectedDistrictId)
                  ? locationState.selectedDistrictId
                  : null,
              items: locationState.selectedCityId == null
                  ? []
                  : locationState.isLoadingDistricts
                      ? [
                          const DropdownMenuItem(
                            value: null,
                            child: Center(
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.tealColor),
                                ),
                              ),
                            ),
                          )
                        ]
                      : locationState.districts
                          .map((district) => DropdownMenuItem(
                                value: district.id,
                                child: Text(district.name),
                              ))
                          .toList(),
              onChanged: locationState.selectedCityId == null ||
                      locationState.isLoadingDistricts
                  ? (_) {}
                  : (value) {
                      locationNotifier.selectDistrict(value);
                      widget.onDistrictChanged(value);
                    },
            ),
            if (widget.streetError != null)
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  top: screenHeight * 0.005,
                ),
                child: Text(
                  widget.streetError!,
                  style: TextStyle(
                    color: AppColors.statusRedColor,
                    fontSize: screenWidth * 0.032,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
              ),
            if (locationState.districtsError != null)
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  top: screenHeight * 0.005,
                ),
                child: Text(
                  locationState.districtsError!,
                  style: TextStyle(
                    color: AppColors.statusRedColor,
                    fontSize: screenWidth * 0.032,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
