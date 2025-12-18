import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/features/authentication_management/data/models/country_model.dart';
import 'package:ikarusapp/features/authentication_management/data/models/city_model.dart';
import 'package:ikarusapp/features/authentication_management/data/models/district_model.dart';
import 'package:ikarusapp/features/authentication_management/data/repositories/location_repository_impl.dart';

class LocationViewModel extends StateNotifier<LocationState> {
  final LocationRepositoryImpl _locationRepository;

  LocationViewModel(this._locationRepository) : super(LocationState.initial());

  // Load countries
  Future<void> loadCountries() async {
    state = state.copyWith(isLoadingCountries: true, countriesError: null);
    
    final result = await _locationRepository.getCountries();
    
    if (result.data != null) {
      state = state.copyWith(
        countries: result.data!,
        isLoadingCountries: false,
      );
    } else {
      state = state.copyWith(
        isLoadingCountries: false,
        countriesError: result.errorMessage ?? "Failed to load countries",
      );
    }
  }

  // Load cities by country code
  Future<void> loadCities(String countryCode) async {
    state = state.copyWith(
      isLoadingCities: true,
      citiesError: null,
      cities: [],
      districts: [],
      selectedCityId: null,
      selectedDistrictId: null,
    );
    
    final result = await _locationRepository.getCities(countryCode);
    
    if (result.data != null) {
      state = state.copyWith(
        cities: result.data!,
        isLoadingCities: false,
      );
    } else {
      state = state.copyWith(
        isLoadingCities: false,
        citiesError: result.errorMessage ?? "Failed to load cities",
      );
    }
  }

  // Load districts by city id
  Future<void> loadDistricts(String cityId) async {
    state = state.copyWith(
      isLoadingDistricts: true,
      districtsError: null,
      districts: [],
      selectedDistrictId: null,
    );
    
    final result = await _locationRepository.getDistricts(cityId);
    
    if (result.data != null) {
      state = state.copyWith(
        districts: result.data!,
        isLoadingDistricts: false,
      );
    } else {
      state = state.copyWith(
        isLoadingDistricts: false,
        districtsError: result.errorMessage ?? "Failed to load districts",
      );
    }
  }

  // Set selected country and load cities
  Future<void> selectCountry(String? countryCode) async {
    state = state.copyWith(
      selectedCountryCode: countryCode,
      cities: [],
      districts: [],
      selectedCityId: null,
      selectedDistrictId: null,
    );
    
    if (countryCode != null && countryCode.isNotEmpty) {
      await loadCities(countryCode);
    }
  }

  // Set selected city and load districts
  Future<void> selectCity(String? cityId) async {
    state = state.copyWith(
      selectedCityId: cityId,
      districts: [],
      selectedDistrictId: null,
    );
    
    if (cityId != null && cityId.isNotEmpty) {
      await loadDistricts(cityId);
    }
  }

  // Set selected district
  void selectDistrict(String? districtId) {
    state = state.copyWith(selectedDistrictId: districtId);
  }

  // Reset all selections
  void reset() {
    state = LocationState.initial();
  }
}

class LocationState {
  final List<CountryModel> countries;
  final List<CityModel> cities;
  final List<DistrictModel> districts;
  final String? selectedCountryCode;
  final String? selectedCityId;
  final String? selectedDistrictId;
  final bool isLoadingCountries;
  final bool isLoadingCities;
  final bool isLoadingDistricts;
  final String? countriesError;
  final String? citiesError;
  final String? districtsError;

  LocationState({
    required this.countries,
    required this.cities,
    required this.districts,
    this.selectedCountryCode,
    this.selectedCityId,
    this.selectedDistrictId,
    this.isLoadingCountries = false,
    this.isLoadingCities = false,
    this.isLoadingDistricts = false,
    this.countriesError,
    this.citiesError,
    this.districtsError,
  });

  factory LocationState.initial() {
    return LocationState(
      countries: [],
      cities: [],
      districts: [],
    );
  }

  LocationState copyWith({
    List<CountryModel>? countries,
    List<CityModel>? cities,
    List<DistrictModel>? districts,
    String? selectedCountryCode,
    String? selectedCityId,
    String? selectedDistrictId,
    bool? isLoadingCountries,
    bool? isLoadingCities,
    bool? isLoadingDistricts,
    String? countriesError,
    String? citiesError,
    String? districtsError,
  }) {
    return LocationState(
      countries: countries ?? this.countries,
      cities: cities ?? this.cities,
      districts: districts ?? this.districts,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      selectedCityId: selectedCityId ?? this.selectedCityId,
      selectedDistrictId: selectedDistrictId ?? this.selectedDistrictId,
      isLoadingCountries: isLoadingCountries ?? this.isLoadingCountries,
      isLoadingCities: isLoadingCities ?? this.isLoadingCities,
      isLoadingDistricts: isLoadingDistricts ?? this.isLoadingDistricts,
      countriesError: countriesError ?? this.countriesError,
      citiesError: citiesError ?? this.citiesError,
      districtsError: districtsError ?? this.districtsError,
    );
  }
}

