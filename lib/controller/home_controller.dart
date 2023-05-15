
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class HomeController extends GetxController {
  User? get user => Get.find<AuthController>().user.value;

  test() {
    log('test: ${FirebaseAuth.instance.currentUser!.displayName}');
    log('test user: ${user!.displayName}');
  }
}
