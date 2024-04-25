part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String rePassword;
  final String userType;
  SignUpEvent({required this.name,required this.email,required this.phone,required this.password,required this.rePassword, required this.userType});
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

final class SignOutEvent extends AuthEvent {
  
}

final class RedirectEvent extends AuthEvent {
}

final class VerifyEmailEvent extends AuthEvent {
  final String email;

  VerifyEmailEvent({required this.email});
}

final class VerifyOtpEvent extends AuthEvent {
  final String otp;
  final String email;

  VerifyOtpEvent({required this.otp, required this.email});
}

final class ChangePasswordEvent extends AuthEvent {
  final String password;
  final String rePassword;

  ChangePasswordEvent({required this.password, required this.rePassword});
}

final class ResendOtpEvent extends AuthEvent {
  final String email;

  ResendOtpEvent({required this.email});
}

final class SwitchEditModeEvent extends AuthEvent {
  final bool isEdit;

  SwitchEditModeEvent({required this.isEdit});
}

final class EditProfileInfoEvent extends AuthEvent {
  final String name;
  final String phone;

  EditProfileInfoEvent({required this.name, required this.phone});
}

final class UploadUserImageEvent extends AuthEvent {
  final File? imgFile;

  UploadUserImageEvent({required this.imgFile});
}

final class GetUserImageEvent extends AuthEvent {

}

final class PickUserImageEvent extends AuthEvent {
  
}