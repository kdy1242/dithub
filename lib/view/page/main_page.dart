

import 'package:dithub/controller/auth_controller.dart';
import 'package:dithub/view/widget/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String route = '/main';

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(Logo.logo),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('main page'),
            Text('${controller.user.value!.uid}'),
            TextButton(
              onPressed: (){
                controller.logout();
              },
              child: Text('로그아웃'))
          ],
        ),
      ),
    );
  }
}

