import 'package:get/get.dart';

class HomeController extends GetxController {
  var pageIndex = 0.obs;

  HomeController();

  _initData() {
    update(["home"]);
  }

  void changePageIdx(int idx) {
    pageIndex.value = idx;
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
