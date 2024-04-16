import 'package:get/get.dart';

import '../modules/first_spalsh/binding/first_splash_binding.dart';
import '../modules/first_spalsh/view/first_spalsh_page.dart';
import '../modules/intro/view/intro_page.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Paths.FirstSplash,
      page: () => const FiestSplashView(),
      binding: FirstSplashBinding(),
    ),
    GetPage(
      name: Paths.Intro,
      page: () => const IntroPage(),
    ),
    // GetPage(
    //   name: _Paths.ConfirmPassword,
    //   page: () => const Confirmpassword(),
    // ),
    // GetPage(
    //     name: _Paths.Password,
    //     page: () => const PasswordPageView(),
    //     binding: PasswordBinding(),
    //     children: [
    //       GetPage(
    //         name: _Paths.ConfirmPassword,
    //         page: () => const Confirmpassword(),
    //       ),
    //     ]),
    // GetPage(
    //   name: _Paths.SignIn,
    //   page: () => SignInPage(),
    //   binding: SignInBinding(),
    // ),

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
