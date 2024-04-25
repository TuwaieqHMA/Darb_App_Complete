import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:darb_app/pages/Map%20Pages/user_location_page.dart';
import 'package:darb_app/pages/Home%20Pages/supervisor_naivgation_page.dart';
import 'package:darb_app/pages/Start%20Pages/welcome_page.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final dbService = DBService();
  final locator = GetIt.I.get<HomeData>();
  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>(signup);
    on<LoginEvent>(login);
    on<SignOutEvent>(signout);
    on<RedirectEvent>(redirect);
    on<VerifyEmailEvent>(verifyEmail);
    on<VerifyOtpEvent>(verifyOtp);
    on<ChangePasswordEvent>(changePassword);
    on<ResendOtpEvent>(resendOtp);
    on<SwitchEditModeEvent>(switchEditMode);
    on<EditProfileInfoEvent>(editProfileInfo);
    on<UploadUserImageEvent>(uploadUserImage);
    on<GetUserImageEvent>(getUserImage);
    on<PickUserImageEvent>(pickUserImage);
  }
// Signup Method
  FutureOr<void> signup(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.name.trim().isNotEmpty &&
        event.email.trim().isNotEmpty &&
        event.phone.trim().isNotEmpty &&
        event.password.trim().isNotEmpty &&
        event.rePassword.trim().isNotEmpty) {
      if (validator.email(event.email)) {
        if (RegExp(r'^05[0-9]{8}$').hasMatch(event.phone)) {
          if (event.password.length >= 6 && event.rePassword.length >= 6) {
            if (event.password == event.rePassword) {
              try {
                AuthResponse res = await dbService.signUp(
                    email: event.email, password: event.password);
                await dbService.addUser(DarbUser(
                    id: res.user!.id,
                    name: event.name,
                    email: event.email,
                    phone: event.phone,
                    userType: event.userType));
                if (event.userType == "Student") {
                  await dbService.addStudent(Student(id: res.user!.id));
                } else if (event.userType == "Driver") {
                  await dbService.addDriver(Driver(
                      id: res.user!.id, supervisorId: locator.currentUser.id!));
                }
                emit(SignedUpState(
                    msg:
                        "تم إنشاء الحساب بنجاح الرجاء تأكيد حسابك عن طريق البريد المرسل لبريدك الإلكتروني"));
              } catch (e) {
                emit(AuthErrorState(msg: "هناك مشكلة في الإتصال بخدمتنا"));
                print(e);
              }
            } else {
              emit(AuthErrorState(msg: "كلمتا السر غير متطابقتين"));
            }
          } else {
            emit(AuthErrorState(msg: "كلمة السر يجب أن تكون من 6 فأكثر"));
          }
        } else {
          emit(AuthErrorState(msg: "الرجاء إدخال رقم هاتف صحيح"));
        }
      } else {
        emit(AuthErrorState(msg: "الرجاء إدخال بريد إلكتروني صحيح"));
      }
    } else {
      emit(AuthErrorState(msg: "الرجاء تعبئة جميع الحقول"));
    }
  }

// Login Method
  FutureOr<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    if (event.email.trim().isNotEmpty && event.password.trim().isNotEmpty) {
      if (validator.email(event.email)) {
        try {
          await dbService.signIn(email: event.email, password: event.password);
          locator.currentUser = await dbService.getCurrentUserInfo();
          getUserImage(GetUserImageEvent(), emit);
          emit(LoggedInState(msg: "تم تسجيل الدخول بنجاح"));
        } catch (e) {
          emit(AuthErrorState(
              msg:
                  "الايميل أو كلمة المرور خاطئة"));
          print(e);
        }
      } else {
        emit(AuthErrorState(msg: "الرجاء إدخال بريد إلكتروني صحيح"));
      }
    } else {
      emit(AuthErrorState(msg: "الرجاء تعبئة جميع الحقول"));
    }
  }

// Signout Method
  FutureOr<void> signout(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    await dbService.signOut();
    locator.currentPageIndex = 0;
    emit(SignedOutState(msg: "تم تسجيل خروجك بنجاح"));
  }

// Redirect Method
  FutureOr<void> redirect(RedirectEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    if (dbService.supabase.auth.currentSession != null) {
      locator.currentUser = await dbService.getCurrentUserInfo();
      getUserImage(GetUserImageEvent(), emit);
      Widget widget;
      switch (locator.currentUser.userType) {
        case "Supervisor":
          widget = const SupervisorNavigationPage();
        case "Student":
          widget = const UserLocationPage();
        case "Driver":
          widget = const UserLocationPage();
        default:
          widget = const WelcomePage();
      }
      emit(RedirectedState(page: widget));
    } else {
      emit(RedirectedState(page: const WelcomePage()));
    }
  }

  FutureOr<void> verifyEmail(
      VerifyEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.email.trim().isNotEmpty) {
      if (validator.email(event.email)) {
        try {
          await dbService.sendOtp(event.email);
          emit(EmailVerifiedState(msg: "تم إرسال الرمز إلى بريدك الإلكتروني"));
        } catch (e) {
          emit(AuthErrorState(
              msg: "هناك مشكلة في عملية التحقق من بريدك الإلكتروني"));
        }
      } else {
        emit(AuthErrorState(msg: "الرجاء إدخال بريد إلكتروني صحيح"));
      }
    } else {
      emit(AuthErrorState(msg: "الرجاء تعبئة البريد الإلكتروني"));
    }
  }

  FutureOr<void> verifyOtp(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    if (event.otp.trim().isNotEmpty) {
      if (event.otp.length == 6) {
        try {
          await dbService.verifyOtp(event.otp, event.email);
          emit(OtpVerifiedState(
              msg: "تم التحقق من الرمز بنجاح، يمكنك الان تغيير كلمة المرور"));
        } catch (e) {
          print(e);
          emit(AuthErrorState(
              msg: "حدث خطأ أثناء عملية التحقق، الرجاء المحاولة مرة أخرى"));
        }
      } else {
        emit(AuthErrorState(msg: "رمز التحقق يتكون من 6 أرقام"));
      }
    } else {
      emit(AuthErrorState(msg: "الرجاء إدخال رمز التحقق"));
    }
  }

  FutureOr<void> changePassword(
      ChangePasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.password.trim().isNotEmpty &&
        event.rePassword.trim().isNotEmpty) {
      if (event.password.length >= 6 && event.rePassword.length >= 6) {
        if (event.password == event.rePassword) {
          try {
            await dbService.changePassword(event.password);
            await dbService.signOut();
            emit(PasswordChangedState(msg: "تم تغيير كلمة السر بنجاح"));
          } catch (e) {
            emit(AuthErrorState(
                msg:
                    "حدث خطأ أثناء عملية تغيير كلمة السر، الرجاء المحاولة لاحقاً"));
          }
        } else {
          emit(AuthErrorState(msg: "كلمتا السر غير متطابقتين"));
        }
      } else {
        emit(
            AuthErrorState(msg: "يجب أن تتكون كلمة السر من 6 خانات على الأقل"));
      }
    } else {
      emit(AuthErrorState(msg: "الرجاء تعبئة جميع الحقول"));
    }
  }

  FutureOr<void> resendOtp(
      ResendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await dbService.resendOtp(event.email);
      emit(OtpResentState(msg: "تم إرسال الرمز بنجاح"));
    } catch (e) {
      print(e);
      emit(AuthErrorState(msg: "هناك خطأ في عملية إعادة إرسال رمز التحقق"));
    }
  }

  FutureOr<void> switchEditMode(SwitchEditModeEvent event, Emitter<AuthState> emit) {
    if(event.isEdit){
      emit(ViewProfileState());
    }else {
      emit(EditingProfileState());
    }
  }

  FutureOr<void> editProfileInfo(EditProfileInfoEvent event, Emitter<AuthState> emit) async{
    emit(AuthLoadingState());

    if(event.name.trim().isNotEmpty && event.phone.trim().isNotEmpty){
      if(RegExp(r'^05[0-9]{8}$').hasMatch(event.phone)){
        await dbService.updateUserInfo(event.name, event.phone);
        locator.currentUser = await dbService.getCurrentUserInfo();
        emit(ViewProfileState());
      }else {
        emit(AuthErrorState(msg: "الرجاء إدخال رقم الجوال بالصيغة الصحيحة بداية ب 05"));
      }
    }else {
      emit(AuthErrorState(msg: "الرجاء تعبئة جميع الحقول"));
    }
  }

  FutureOr<void> uploadUserImage(UploadUserImageEvent event, Emitter<AuthState> emit) async{
    emit(AuthLoadingState());

    if(event.imgFile != null){
      try {
        await dbService.uploadImage(event.imgFile!);
        dbService.getCurrentUserImage();
        emit(ChangedImageState(msg: "تم تحديث الصورة الخاصة بك بنجاح"));
      } on StorageException catch(_) {
        await dbService.updateImage(event.imgFile!);
        emit(ChangedImageState(msg: "تم تحديث الصورة الخاصة بك بنجاح"));
      } catch (e){
        emit(AuthErrorState(msg: "حدث خطأ في تحديث الصورة الخاصة بك"));
      }
    }else {
      emit(AuthErrorState(msg: "لم يتم إختيار صورة"));
    }
  }

  FutureOr<void> getUserImage(GetUserImageEvent event, Emitter<AuthState> emit) {
    try {
      dbService.getCurrentUserImage();
    } catch (e) {
      emit(AuthErrorState(msg: "هناك مشكلة في تحميل الصورة الخاصة بك"));
    }
  }

  FutureOr<void> pickUserImage(PickUserImageEvent event, Emitter<AuthState> emit) {
    emit(ChangedImageState());
  }
}
