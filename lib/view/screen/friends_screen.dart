
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/friends_controller.dart';


class FriendsScreen extends GetView<FriendsController> {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TabBar(
            controller: controller.tabController,
            tabs: controller.tabs,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: controller.tabViews,
            ),
          ),
        ],
      ),
    );
  }
}
