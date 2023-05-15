
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';
import 'set_profile_controller.dart';
import '../util/app_routes.dart';

class SettingController extends GetxController {

  User? get user => Get.find<AuthController>().user.value;

  editProfilePhoto() => Get.find<SetProfileController>().addProfilePhoto();

  logout() => Get.find<AuthController>().logout();

  editProfile() => Get.offAndToNamed(AppRoutes.setName);
}
