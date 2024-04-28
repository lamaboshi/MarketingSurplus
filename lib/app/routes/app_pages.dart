import 'package:get/get.dart';

import '../modules/first_spalsh/binding/first_splash_binding.dart';
import '../modules/first_spalsh/view/first_spalsh_page.dart';
import '../modules/home/binding/home_binding.dart';
import '../modules/home/view/home_page.dart';
import '../modules/intro/view/intro_page.dart';
import '../modules/log_in/binding/log_in_binding.dart';
import '../modules/log_in/view/log_in_page.dart';
import '../modules/password/binding/password_binding.dart';
import '../modules/password/view/confirm_passwod.dart';
import '../modules/password/view/password_page.dart';
import '../modules/sign_up/binding/sign_up_binding.dart';
import '../modules/sign_up/view/sign_up_page.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: Paths.FirstSplash,
      page: () => const FiestSplashView(),
      binding: FirstSplashBinding(),
    ),

    GetPage(
        name: Paths.Password,
        page: () => const PasswordPageView(),
        binding: PasswordBinding(),
        children: [
          GetPage(
            name: Paths.ConfirmPassword,
            page: () => const Confirmpassword(),
          ),
        ]),
    GetPage(
        name: Paths.SignUpUserPage,
        page: () => const SignUpView(),
        binding: SignUpBinding()),

    GetPage(
      name: Paths.Intro,
      page: () => const IntroPage(),
    ),

    GetPage(
      name: Paths.LogIn,
      page: () => const LogInView(),
      binding: LogInBinding(),
    ),
    // GetPage(
    //   name: _Paths.HAYA,
    //   page: () => const HayaView(),
    //   binding: HayaBinding(),
    // ),
    // GetPage(
    //   name: _Paths.Content,
    //   page: () => const ContentView(),
    //   binding: ContentBinding(),
    // ),
    // GetPage(name: _Paths.HOME, page: () => const HomeView(), bindings: [
    //   HomeBinding(),
    //   HomeMainBinding(),
    //   MenuBinding(),
    //   ProfileBinding()
    // ], middlewares: [
    //   AuthMiddlware()
    // ], children: [
    //   GetPage(
    //     name: _Paths.EditProfile,
    //     page: () => EditProfilePage(),
    //   ),
    // ]),
  ];
}
