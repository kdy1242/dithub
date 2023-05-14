
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';
import 'set_name_controller.dart';

class SettingController extends GetxController {

  User? get user => Get.find<AuthController>().user.value;

  editProfilePhoto() => Get.find<SetNameController>().addProfilePhoto();

  logout() => Get.find<AuthController>().logout();
}
