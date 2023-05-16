
import 'package:dithub/controller/todo_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'controller/friends_controller.dart';
import 'firebase_options.dart';
import 'controller/auth_controller.dart';
import 'controller/login_controller.dart';
import 'controller/signup_controller.dart';
import 'controller/set_profile_controller.dart';
import 'controller/main_controller.dart';
import 'controller/setting_controller.dart';
import 'controller/home_controller.dart';
import 'controller/diary_controller.dart';
import 'util/app_pages.dart';
import 'util/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.lazyPut(() => LoginController(), fenix: true);
        Get.lazyPut(() => SignupController(), fenix: true);
        Get.lazyPut(() => SetProfileController(), fenix: true);
        Get.lazyPut(() => MainController(), fenix: true);
        Get.lazyPut(() => SettingController(), fenix: true);
        Get.lazyPut(() => FriendsController(), fenix: true);
        Get.lazyPut(() => HomeController(), fenix: true);
        Get.lazyPut(() => DiaryController(), fenix: true);
        Get.lazyPut(() => TodoController(), fenix: true);
      }),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.login,
    );
  }
}
