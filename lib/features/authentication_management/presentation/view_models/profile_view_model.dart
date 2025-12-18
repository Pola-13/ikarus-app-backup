import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_profile_response.dart';
import 'package:ikarusapp/features/authentication_management/data/repositories/user_repository_impl.dart';

class ProfileViewModel extends StateNotifier<ProfileState> {
  final UserRepositoryImpl _userRepository;

  ProfileViewModel(this._userRepository) : super(ProfileState.initial());

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _userRepository.getUserProfile();

    if (result.data != null && result.data!.customer != null) {
      state = state.copyWith(
        profile: result.data,
        isLoading: false,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.errorMessage ?? "Failed to load profile",
      );
    }
  }
}

class ProfileState {
  final UserProfileResponse? profile;
  final bool isLoading;
  final String? error;

  ProfileState({
    this.profile,
    this.isLoading = false,
    this.error,
  });

  factory ProfileState.initial() {
    return ProfileState();
  }

  ProfileState copyWith({
    UserProfileResponse? profile,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

