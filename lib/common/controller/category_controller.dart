import 'package:get/get.dart';
import 'package:time_tracker/common/dao/category_dao.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/common/model/event_category.dart';

class CategoryController extends GetxController {
  var categories = <EventCategory>[].obs;

  final totalDuration = const Duration(seconds: 0).obs;

  /// 计算总时间
  void calculateTotalDuration() {
    totalDuration.value = const Duration(seconds: 0);

    for (EventCategory category in categories) {
      if (category.events != null) {
        for (Event event in category.events!) {
          totalDuration.value += event.duration ?? const Duration(seconds: 0);
        }
      }
    }
  }

  CategoryController() {
    featchData();
    calculateTotalDuration();
  }

  void featchData() async {
    categories.value = await CategoryDao.fetchCategories();
    calculateTotalDuration();
  }

  void featchDateOfDate(DateTime date) async {
    categories.value = await CategoryDao.fetchCategoriesByDate(date);
    calculateTotalDuration();
  }

  void featchDateOfDateRange(DateTime startDate, DateTime endDate) async {
    List<EventCategory>? result =
        await CategoryDao.fetchCategoriesByDateRange(startDate, endDate);

    if (result != null) {
      categories.value = result;
    }

    calculateTotalDuration();
  }
}
