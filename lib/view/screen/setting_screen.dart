
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/setting_controller.dart';
import '../../util/fonts.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                color: Colors.white,
              ),
              Positioned(
                left: 20,
                top: 0,
                bottom: 0,
                right: 0,
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        radius: 36,
                        backgroundImage: controller.user!.photoURL != null
                          ? NetworkImage(controller.user!.photoURL!)
                          : null,
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.user!.displayName ?? '이름 없음', style: NotoSans.bold.copyWith(fontSize: 20)),
                        SizedBox(height: 8),
                        Text(controller.user!.email!, style: NotoSans.medium.copyWith(fontSize: 16, color: Colors.grey)),
                      ],
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 36.0),
                        child: Container(
                          width: 40,
                          height: 40,
                          child: CircleAvatar(
                            radius: 36,
                            child: Icon(Icons.edit, color: Colors.white),
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 56,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('공지사항', style: NotoSans.medium.copyWith(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.navigate_next),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 56,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('이용안내', style: NotoSans.medium.copyWith(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.navigate_next),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 56,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('문의하기', style: NotoSans.medium.copyWith(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.navigate_next),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 56,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('이용약관', style: NotoSans.medium.copyWith(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.navigate_next),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 56,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('버전정보', style: NotoSans.medium.copyWith(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text('1.0.0', style: NotoSans.bold.copyWith(fontSize: 16)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.red
                ),
                onPressed: controller.logout,
                child: Text('로그아웃', style: NotoSans.regular),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
