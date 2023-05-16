
import 'package:dithub/view/page/diary_detail_page.dart';
import 'package:dithub/view/widget/diary_title_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/diary_controller.dart';
import '../../util/fonts.dart';

class HomeDiaryScreen extends GetView<DiaryController> {
  const HomeDiaryScreen({Key? key, required this.user, required this.addBtnVisible}) : super(key: key);
  final user;
  final bool addBtnVisible;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
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
              trailing: Visibility(
                visible: addBtnVisible,
                child: GestureDetector(
                  onTap: controller.onTapAddDiaryBtn,
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
            ),
            Obx(
              () => TableCalendar(
                locale: 'ko_KR',
                firstDay: DateTime.utc(2021, 1, 1),
                lastDay: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
                focusedDay: controller.focusedDay.value,
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
                calendarBuilders: CalendarBuilders(
                  todayBuilder: (context, date, _) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2.0),
                      ),
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  },
                  markerBuilder: (context, date, events) {
                    bool hasMarker = controller.diaryList.any((diary) {
                      return diary.timestamp.year == date.year &&
                          diary.timestamp.month == date.month &&
                          diary.timestamp.day == date.day;
                    });

                    if (hasMarker) {
                      return Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.green,
                        ),
                      );
                    }
                    return Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 14),
            Text('최근 일기', style: NotoSans.bold.copyWith(fontSize: 18)),
            SizedBox(height: 8),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.grey[200],
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.diaryList.length,
                    itemBuilder: (context, index) {
                      var diary = controller.diaryList[index];
                      return GestureDetector(
                          onTap: () {
                            Get.to(() => DiaryDetailPage(diary: diary));
                          },
                          child: DiaryTitleItem(diary: diary)
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
