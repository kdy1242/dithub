
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../util/app_routes.dart';
import 'auth_controller.dart';

class SetNameController extends GetxController {

  TextEditingController nameController = TextEditingController();

  User? get user => Get.find<AuthController>().user.value;


  addProfilePhoto() async {
    var picker = ImagePicker();
    var res = await picker.pickImage(source: ImageSource.gallery);
    if (res != null) {
      // 스토리지 올리기
      var ref = FirebaseStorage.instance.ref('profile/${user!.uid}');
      await ref.putFile(File(res.path));
      var downloadUrl = await ref.getDownloadURL();
      print(downloadUrl);
      // downloadUrl 받기
      user!.updatePhotoURL(downloadUrl);
    }
  }

  onTapStartBtn() {
    user!.updateDisplayName(nameController.text);
    Get.toNamed(AppRoutes.main);
  }

  @override
  void onInit() {
    super.onInit();
    nameController.text = user!.displayName ?? '이름 입력';
  }
}
