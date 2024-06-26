import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/controller/record_controller.dart';
import 'package:time_tracker/common/dao/record_dao.dart';
import 'package:time_tracker/common/model/event.dart';

import 'package:time_tracker/common/model/event_record.dart';
import 'package:time_tracker/common/utils/data.dart';
import 'package:time_tracker/page/time_line/time_line_page.dart';
import 'package:time_tracker/page/time_line/time_line_page_controller.dart';

class TimegridController extends GetxController {
  RecordController recordController = Get.find();
  TimeLinePageController timeLinePageController = Get.find();

  /// 当前的时间
  var currentTime = DateTime.now().obs;

  /// 行数
  var rowNum = 24.obs;

  /// 每个格子代表的分钟数
  var splitSpan = 5.obs;

  /// 列数
  var colNum = 12.obs;

  /// 保存格子的选中状态
  var cellSelected = <RxList<bool>>[].obs;

  /// 保存起始选中的行
  var startRow = 0;

  /// 保存起始选中的列
  var startCol = 0;

  /// 是否处于选中状态
  var isSelecting = false;

  /// 每个格子的宽度
  var eachWidth = 0.0.obs;

  /// 每个格子的高度
  var eachHeight = 0.0.obs;

  /// 保存当前选中的时间区间
  var startTime = DateTime.now().obs;
  var endTime = DateTime.now().obs;

  List<EventRecord> records = DataUtils.generateTestRecords();

  /// 当前视图模式
  var viewMode = ViewMode.timeGrid.obs;

  TimegridController();

  /// 检查是否选择了时间区间
  bool checkSelected() {
    if (startTime.value == endTime.value) {
      return false;
    }
    return true;
  }

  /// 添加事件
  void addRecord(Event event) async {
    // 检查是否选择了时间区间
    if (!checkSelected()) {
      Get.snackbar("错误", "请选择时间区间");
      return;
    }

    // 这里要做开始时间和结束时间的对换，保证开始时间小于结束时间
    DateTime tmp = startTime.value;
    if (startTime.value.isAfter(endTime.value)) {
      startTime.value = endTime.value;
      endTime.value = tmp;
    }

    EventRecord? record =
        await RecordDao.addRecord(startTime.value, endTime.value, event.id!);

    if (record != null) {
      // 拉取数据
      recordController
          .fetchRecordByDay(timeLinePageController.focusedDay.value);

      _clearSelected();
    }
  }

  /// 清空选中状态
  void _clearSelected() {
    for (int i = 0; i < rowNum.value; i++) {
      for (int j = 0; j < colNum.value; j++) {
        cellSelected[i][j] = false;
      }
    }

    isSelecting = false;
  }

  /// 当手指按下网格，记录起始位置，同时更新选中状态
  void onTouchLayerDown(DragDownDetails details) {
    isSelecting = !isSelecting;

    // 如果当前是非选中状态，那就说明现在是取消选中，直接返回
    if (!isSelecting) {
      if (kDebugMode) {
        print("取消选中");
      }
      _clearSelected();
      return;
    }

    if (kDebugMode) {
      print("开始选中");
    }

    // 计算按下的位置
    // 设置起始选中的格子
    startRow = (details.localPosition.dy / eachHeight.value).floor();
    startCol = (details.localPosition.dx / eachWidth.value).floor();

    // 更新选中的时间
    startTime.value = _getTimeByPosition(startRow, startCol - 1);

    // 更新选中状态
    if (startRow >= 0 &&
        startRow < rowNum.value &&
        startCol >= 0 &&
        startCol < colNum.value &&
        isSelecting) {
      cellSelected[startRow][startCol] = true;
    }
  }

  /// 通过网格的位置得到时间
  DateTime _getTimeByPosition(int row, int col) {
    return DateTime(
        timeLinePageController.focusedDay.value.year,
        timeLinePageController.focusedDay.value.month,
        timeLinePageController.focusedDay.value.day,
        row,
        (col + 1) * splitSpan.value);
  }

  /// 当手指在网格上移动
  void onTouchLayerUpdate(DragUpdateDetails details) {
    // 如果当前是非选中状态，那就说明现在是取消选中，直接返回
    if (!isSelecting) {
      return;
    }
    // 计算按下的位置
    int row = (details.localPosition.dy / eachHeight.value).floor();
    int col = (details.localPosition.dx / eachWidth.value).floor();

    // 更新选中状态
    if (row >= 0 && row < rowNum.value && col >= 0 && col < colNum.value) {
      // 实现算法实现跨行选中
      setCellSelected(row, col);
    }

    // 更新选中的时间
    endTime.value = _getTimeByPosition(row, col);

    if (kDebugMode) {
      print("startTime: ${startTime.value}");
      print("endTime: ${endTime.value}");
    }
  }

  /// 当手指抬起
  void onTouchLayerUp(DragEndDetails details) {
    /// todo
  }

  /// 通过 constraints 来计算每个格子的宽高
  void calculateEachWidthAndHeight(BoxConstraints constraints) {
    eachWidth.value = constraints.maxWidth / colNum.value;
    eachHeight.value = constraints.maxHeight / rowNum.value;
  }

  @override
  void onInit() {
    super.onInit();

    initCellSelected();
    // 更新列数
    updateColNum();
  }

  /// 初始化格子的选中状态
  void initCellSelected() {
    for (int i = 0; i < rowNum.value; i++) {
      List<bool> row = [];
      for (int j = 0; j < colNum.value; j++) {
        row.add(false);
      }
      cellSelected.add(row.obs);
    }
  }

  /// 根据时间间隔更新列数
  void updateColNum() {
    colNum.value = 60 ~/ splitSpan.value;
  }

  _initData() {
    update(["timegrid"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();

    // 设置定时器，每秒更新一次时间
    Timer.periodic(const Duration(seconds: 1), (timer) {
      updateTimeCursor();
      update(["timegrid"]);
    });
  }

  /// 更新时间
  void updateTimeCursor() {
    currentTime.value = DateTime.now();
  }

  /// 算法实现跨行选中
  void setCellSelected(int row, int col) {
    // 如果原地选中，就不变
    if (startRow == row && startCol == col) {
      return;
    }

    // 清空
    for (int i = 0; i < rowNum.value; i++) {
      for (int j = 0; j < colNum.value; j++) {
        cellSelected[i][j] = false;
      }
    }

    // 如果是同一行
    if (row == startRow) {
      // 如果是正向选中
      if (col > startCol) {
        for (int i = startCol; i <= col; i++) {
          cellSelected[row][i] = true;
        }
      }
      // 如果是反向选中
      else {
        for (int i = startCol; i >= col; i--) {
          cellSelected[row][i] = true;
        }
      }
      return;
    }

    // 实现正向选中
    if (row > startRow) {
      for (int i = startCol; i < colNum.value; i++) {
        cellSelected[startRow][i] = true;
      }
      // 将中间的行选完
      for (int i = startRow + 1; i < row; i++) {
        for (int j = 0; j < colNum.value; j++) {
          cellSelected[i][j] = true;
        }
      }

      // 选中最后一行
      for (int i = 0; i <= col; i++) {
        cellSelected[row][i] = true;
      }

      return;
    }

    // 实现反向选中
    else {
      // 将开始的那行选完
      for (int i = startCol; i >= 0; i--) {
        cellSelected[startRow][i] = true;
      }

      // 将中间的行选完
      for (int i = startRow - 1; i > row; i--) {
        for (int j = colNum.value - 1; j >= 0; j--) {
          cellSelected[i][j] = true;
        }
      }

      // 选中最后一行
      for (int i = colNum.value - 1; i >= col; i--) {
        cellSelected[row][i] = true;
      }
    }
  }

  void changeViewMode(timeLine) {
    viewMode.value = timeLine;
    update(["timegrid"]);
  }
}
