
import 'package:dithub/util/app_routes.dart';
import 'package:get/get.dart';

class DiaryController extends GetxController {
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
  }

  addDiary() {
    Get.toNamed(AppRoutes.addDiary);
  }
}
