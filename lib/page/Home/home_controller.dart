import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeController extends GetxController {
  var pagIndex = 0.obs;
  SidebarXController sidebarXController =
      Get.put(SidebarXController(selectedIndex: 0), tag: "sidebarXController");

  HomeController();

  _initData() {
    update(["home"]);
  }

  updatePageIndex() {
    pagIndex.value = sidebarXController.selectedIndex;
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }
}
