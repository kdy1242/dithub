
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../util/fonts.dart';

class AddDiaryPage extends StatelessWidget {
  const AddDiaryPage({Key? key}) : super(key: key);
  static const String route = '/addDiary';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text('일기 작성', style: NotoSans.bold),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text('${DateFormat('yyyy / MM / dd').format(DateTime.now())}', style: NotoSans.regular.copyWith(fontSize: 22, color: Colors.grey),),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: '제목을 입력하세요',
                    hintStyle: NotoSans.regular.copyWith(fontSize: 20),
                    border: InputBorder.none,
                  ),
                ),
                Divider(),
                TextField(
                  decoration: InputDecoration(
                    hintText: '${FirebaseAuth.instance.currentUser!.displayName}님의 하루는 어땠나요?',
                    hintStyle: NotoSans.regular.copyWith(fontSize: 18),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

