import 'package:get/get.dart';
import 'package:notesapp/features/auth/presentation/login/login_binding.dart';
import 'package:notesapp/features/auth/presentation/signup/signup_binding.dart';
import 'package:notesapp/features/auth/presentation/signup/signup_page.dart';
import 'package:notesapp/features/auth/presentation/splash/splash_binding.dart';
import 'package:notesapp/features/notes/presentation/editNote/edit_note_bindings.dart';
import 'package:notesapp/features/notes/presentation/editNote/edit_note_page.dart';
import 'package:notesapp/features/notes/presentation/home/home_binding.dart';
import 'package:notesapp/features/notes/presentation/home/home_page.dart';

import '../features/auth/presentation/emailVerification/email_verification_page.dart';
import '../features/auth/presentation/forgotPassword/frogot_password.dart';
import '../features/auth/presentation/login/login_page.dart';
import '../features/auth/presentation/splash/splash_page.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupPage(),
      binding: SignupBindings(),
    ),
    GetPage(name: Routes.FORGOT_PASSWORD, page: () => ForgotPasswordPage()),
    GetPage(
      name: Routes.EMAIL_VERIFICATION,
      page: () => EmailVerificationPage(),
    ),
    GetPage(
      name: Routes.ADD_NOTE,
      page: () => EditNotePage(),
      binding: EditNoteBindings(),
    ),
    GetPage(
      name: Routes.EDIT_NOTE,
      page: () => EditNotePage(),
      binding: EditNoteBindings(),
    ),
  ];
}
