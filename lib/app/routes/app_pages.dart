import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/admin/binding/admin_binding.dart';
import 'package:marketing_surplus/app/modules/admin/view/admin_page.dart';
import 'package:marketing_surplus/app/modules/bills/binding/bills_binding.dart';
import 'package:marketing_surplus/app/modules/charity/binding/charity_binding.dart';
import 'package:marketing_surplus/app/modules/charity/view/charity_details.dart';
import 'package:marketing_surplus/app/modules/company/binding/company_binding.dart';
import 'package:marketing_surplus/app/modules/company/view/company_view.dart';
import 'package:marketing_surplus/app/modules/product/binding/product_binding.dart';
import 'package:marketing_surplus/app/modules/product/view/produtc_page.dart';
import 'package:marketing_surplus/app/modules/profile/view/profile_page.dart';
import 'package:marketing_surplus/app/modules/setting_profile/binding/setting_profile_binding.dart';
import 'package:marketing_surplus/app/modules/setting_profile/view/setting_profile_page.dart';

import '../modules/first_spalsh/binding/first_splash_binding.dart';
import '../modules/first_spalsh/view/first_spalsh_page.dart';
import '../modules/home/binding/home_binding.dart';
import '../modules/home/view/home_page.dart';
import '../modules/intro/binding/intro_binding.dart';
import '../modules/intro/view/intro_page.dart';
import '../modules/log_in/binding/log_in_binding.dart';
import '../modules/log_in/view/log_in_page.dart';
import '../modules/menu/binding/menu_binding.dart';
import '../modules/password/binding/password_binding.dart';
import '../modules/password/view/confirm_passwod.dart';
import '../modules/password/view/password_page.dart';
import '../modules/profile/binding/profile_binding.dart';
import '../modules/sign_up/binding/sign_up_binding.dart';
import '../modules/sign_up/view/sign_up_page.dart';
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
        binding: IntroBinding()),
    GetPage(name: Paths.HOME, page: () => const HomeView(), bindings: [
      HomeBinding(),
      BillsBinding(),
      ProfileBinding(),
      MenuBinding(),
      CharityBinding()
    ]),
    GetPage(
      name: Paths.CharityDetails,
      page: () => const CharityDetails(),
    ),
    GetPage(
      name: Paths.Profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Paths.ADMIN,
      page: () => const AdminView(),
      binding: AdminBinding(),
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
      name: Paths.LogIn,
      page: () => const LogInView(),
      binding: LogInBinding(),
    ),
    GetPage(
      name: Paths.SettingProfile,
      page: () => const SettingProfileView(),
      binding: SettingProfileBinding(),
    ),
    GetPage(
      name: Paths.PRODUCT_PAGE,
      page: () => ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Paths.COMPANY_PAGE,
      page: () => const CompanyView(),
      binding: CompanyBinding(),
    ),
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
