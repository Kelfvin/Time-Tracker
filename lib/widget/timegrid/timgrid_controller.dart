import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimegridController extends GetxController {
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

  TimegridController();

  /// 清空选中状态
  void clearSelected() {
    for (int i = 0; i < rowNum.value; i++) {
      for (int j = 0; j < colNum.value; j++) {
        cellSelected[i][j] = false;
      }
    }
  }

  /// 当手指按下网格
  void onTouchLayerDown(DragDownDetails details) {
    isSelecting = !isSelecting;

    //  按下的时候先清除上一次的选中状态
    clearSelected();

    // 计算按下的位置
    int row = (details.localPosition.dy / eachHeight.value).floor();
    int col = (details.localPosition.dx / eachWidth.value).floor();

    // 设置起始选中的格子
    startRow = row;
    startCol = col;

    // 更新选中状态
    if (row >= 0 &&
        row < rowNum.value &&
        col >= 0 &&
        col < colNum.value &&
        isSelecting) {
      cellSelected[row][col] = true;
    }
  }

  /// 当手指在网格上移动
  void onTouchLayerUpdate(DragUpdateDetails details) {
    if (!isSelecting) {
      return;
    }
    // 计算按下的位置
    int row = (details.localPosition.dy / eachHeight.value).floor();
    int col = (details.localPosition.dx / eachWidth.value).floor();

    // 更新选中状态
    if (row >= 0 &&
        row < rowNum.value &&
        col >= 0 &&
        col < colNum.value &&
        isSelecting) {
      // 实现算法实现跨行选中
      setCellSelected(row, col);
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
    Timer.periodic(Duration(seconds: 1), (timer) {
      updateTimeCursor();
      update(["timegrid"]);
    });
  }

  /// 更新时间
  updateTimeCursor() {
    currentTime.value = DateTime.now();
  }

  /// 算法实现跨行选中
  setCellSelected(int row, int col) {
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

    if (row > startRow) {
      print("正向选中");
      // 将开始的那行选完
      print("startRow: $startRow, startCol: $startCol");
      print("row: $row, col: $col");

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
    }

    // 实现反向选中
    else {
      print("反向选中");
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
}
