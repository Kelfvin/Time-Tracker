import 'package:get/get.dart';
import 'package:time_tracker/common/dao/category_dao.dart';
import 'package:time_tracker/common/model/event_category.dart';

class CategoryController extends GetxController {
  var categories = <EventCategory>[].obs;

  CategoryController() {
    featchData();
  }

  void featchData() async {
    categories.value = await CategoryDao.fetchCategories();
  }

  void featchDateOfDate(DateTime date) async {
    categories.value = await CategoryDao.fetchCategoriesByDate(date);
  }
}
