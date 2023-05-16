
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/diary_controller.dart';
import '../../util/fonts.dart';

class HomeDiaryScreen extends GetView<DiaryController> {
  const HomeDiaryScreen({Key? key, required this.user}) : super(key: key);
  final user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
          leading: CircleAvatar(
            radius: 36,
            backgroundColor: Colors.grey,
            child: user.profileImg == null ? Icon(Icons.person, color: Colors.white) : null,
            backgroundImage: user.profileImg != null
              ? NetworkImage(user.profileImg!)
              : null,
          ),
          title: Text(user.name),
          subtitle: Text(user.email),
          trailing: GestureDetector(
            onTap: controller.addDiary,
            child: Container(
              width: 48,
              height: 48,
              child: CircleAvatar(
                radius: 36,
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ),
        Obx(
          () => TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2021, 1, 1),
            lastDay: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
            focusedDay: controller.focusedDay.value,
            selectedDayPredicate: (day) {
              return isSameDay(controller.selectedDay.value, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              controller.onDaySelected(selectedDay, focusedDay);
            },
            headerStyle: HeaderStyle(
              titleCentered: true,
              titleTextFormatter: (date, locale) =>
                  DateFormat.yMMMM(locale).format(date),
              formatButtonVisible: false,
              headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
            ),
          ),
        ),
      ],
    );
  }
}
