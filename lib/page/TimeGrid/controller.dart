import 'package:get/get.dart';

class TimegridController extends GetxController {
  int currentHour = 0;
  int currentMinute = 0;
  int rowNum = 0;
  int colNum = 0;

  double eachHeight = 0;
  double eachWidth = 0;

  // 保存格子的选中状态
  List<List<bool>> cellSelected = [];

  // 保存起始选中的格子
  int startRow = 0;
  int startCol = 0;

  // 是否处于选中状态
  bool isSelecting = false;

  TimegridController();

  _initData() {
    update(["timegrid"]);
  }

  void onTap() {}

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
