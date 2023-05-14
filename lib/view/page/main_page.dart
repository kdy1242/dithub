

import 'package:dithub/controller/auth_controller.dart';
import 'package:dithub/view/widget/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);
  static const String route = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,   // 자동 뒤로가기 버튼 생성 비활성화
        title: Image.asset(Logo.logo),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        itemCount: controller.screens.length,
        itemBuilder: (context, index) {
          return controller.screens[index];
        }
      ),
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text('main page'),
      //       Text('${controller.user!.uid}'),
      //       Text('${controller.user!.displayName}'),
      //       // TextButton(
      //       //   onPressed: (){
      //       //     controller.logout();
      //       //   },
      //       //   child: Text('로그아웃')
      //       // )
      //     ],
      //   ),
      // ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          onTap: controller.onPageTapped,
          currentIndex: controller.curPage.value,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.person_search), label: '친구'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: '할일'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
          ],
        ),
      ),
    );
  }
}

