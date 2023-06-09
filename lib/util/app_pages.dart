
import 'package:get/get.dart';

import '../view/page/diary_edit_page.dart';
import '../view/page/login_page.dart';
import '../view/page/main_page.dart';
import '../view/page/diary_add_page.dart';
import '../view/page/set_profile_page.dart';
import '../view/page/signup_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: MainPage.route, page: () => const MainPage()),
    GetPage(name: LoginPage.route, page: () => const LoginPage()),
    GetPage(name: SignUpPage.route, page: () => const SignUpPage()),
    GetPage(name: SetProfilePage.route, page: () => const SetProfilePage()),
    GetPage(name: DiaryAddPage.route, page: () => const DiaryAddPage()),
  ];
}
