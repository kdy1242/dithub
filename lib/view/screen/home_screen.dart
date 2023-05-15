
import 'package:dithub/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/fonts.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      child: CircleAvatar(
                        radius: 36,
                        backgroundImage: controller.user!.photoURL != null
                          ? NetworkImage(controller.user!.photoURL!)
                          : null,
                      ),
                    ),
                    SizedBox(height: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('me', style: NotoSans.regular),
                      ],
                    ),
                  ],
                ),
                TextButton(onPressed: controller.test, child: Text('ㅌㅅㅌ'),),
              ],
            ),
          )
        ],
      ),
    );
  }
}

