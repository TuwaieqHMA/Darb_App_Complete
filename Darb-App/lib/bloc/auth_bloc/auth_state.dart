part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignedUpState extends AuthState {
  final String msg;

  SignedUpState({required this.msg});
}

final class LoggedInState extends AuthState {
  final String msg;

  LoggedInState({required this.msg});
}

final class SignedOutState extends AuthState {
  final String msg;

  SignedOutState({required this.msg});
}

final class RedirectedState extends AuthState {
  final Widget page;

  RedirectedState({required this.page});
}

final class EmailVerifiedState extends AuthState {
  final String msg;

  EmailVerifiedState({required this.msg});
}

final class OtpVerifiedState extends AuthState {
  final String msg;

  OtpVerifiedState({required this.msg});
}

final class PasswordChangedState extends AuthState {
  final String msg;

  PasswordChangedState({required this.msg});
}

final class OtpResentState extends AuthState {
  final String msg;

  OtpResentState({required this.msg});
}

final class AuthLoadingState extends AuthState {

}

final class AuthErrorState extends AuthState {
  final String msg;

  AuthErrorState({required this.msg});
}

final class ViewProfileState extends AuthState {

}

final class EditingProfileState extends AuthState {
  
}

final class ChangedImageState extends AuthState {
  final String? msg;

  ChangedImageState({this.msg});
}