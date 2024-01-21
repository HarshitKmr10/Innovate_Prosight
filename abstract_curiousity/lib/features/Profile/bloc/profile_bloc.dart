import 'package:abstract_curiousity/Features/Profile/services/profile_repository.dart';
import 'package:abstract_curiousity/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc({required this.profileRepository}) : super(ProfileLoading()) {
    on<ProfileDetailsRequested>((event, emit) async {
      emit(ProfileLoading());
      try {
        CustomUser? _customuser =
            await profileRepository.getCurrentNameAndBio();
        emit(ProfileLoaded(customUser: _customuser!));
      } catch (e) {
        emit(ProfileError("Unable to Load data"));
        emit(ProfileNotFetched());
      }
    });

    on<ProfileDataUpdateRequested>((event, emit) async {
      emit(ProfileLoading());
      try {
        profileRepository.updateNameAndBio(
          name: event.name,
          bio: event.bio,
          context: event.context,
          email: event.email,
        );
        emit(ProfileLoaded());
      } catch (e) {
        emit(ProfileError("Unable to Load data"));
        emit(ProfileNotFetched());
      }
    });
  }
}
