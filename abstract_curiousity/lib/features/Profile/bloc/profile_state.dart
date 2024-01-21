part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {}

class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  final CustomUser? customUser;

  ProfileLoaded({this.customUser});
  @override
  List<Object?> get props => [customUser];
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);

  @override
  List<Object?> get props => [];
}

class ProfileNotFetched extends ProfileState {
  @override
  List<Object?> get props => [];
}
