part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

@override
class GoogleSignInRequested extends AuthEvent {}

@override
class SaveToBackendRequested extends AuthEvent {}

@override
class LogOutRequested extends AuthEvent {}
