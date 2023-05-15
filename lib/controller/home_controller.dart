
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class HomeController extends GetxController {
  User? get user => Get.find<AuthController>().user.value;


}
