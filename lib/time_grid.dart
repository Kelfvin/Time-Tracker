import 'package:flutter/material.dart';

class TimeGrid extends StatefulWidget {
  final int splitSpan;

  TimeGrid({required this.splitSpan});

  @override
  _TimeGridState createState() => _TimeGridState(splitSpan);
}

class _TimeGridState extends State<TimeGrid> {
  List<List<Color>> cellColors = [];
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

  _TimeGridState(int splitSpan) {
    this.rowNum = 24;
    this.colNum = 60 ~/ splitSpan;
  }

  // 初始化格子的选中状态
  void initCellSelected() {
    for (int i = 0; i < rowNum; i++) {
      List<bool> row = [];
      for (int j = 0; j < colNum; j++) {
        row.add(false);
      }
      cellSelected.add(row);
    }
  }

  @override
  void initState() {
    super.initState();
    updateTimeCursor();
    initCellSelected();
  }

  void updateTimeCursor() {
    DateTime currentTime = DateTime.now();
    currentHour = currentTime.hour;
    currentMinute = currentTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // 获取父组件的高度
      double height = constraints.maxHeight;
      // 获取父组件的宽度
      double width = constraints.maxWidth;

      // 计算每个格子的高度
      eachHeight = height / rowNum;
      // 计算每个格子的宽度
      eachWidth = width / colNum;

      return Stack(
        children: [
          generateBackgroundGrid(),
          generateSelectedGrid(),
          generateTimeCursor(),
          generateGuestureDetector(),
        ],
      );
    });
  }

  // 显示选中的格子
  Widget generateSelectedGrid() {
    return Column(children: [
      for (int i = 0; i < rowNum; i++)
        Expanded(
          child: Row(
            children: [
              for (int j = 0; j < colNum; j++)
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                      color: cellSelected[i][j]
                          ? Color.fromARGB(255, 19, 148, 223)
                          : Colors.transparent,
                    ),
                  ),
                ),
            ],
          ),
        ),
    ]);
  }

  Widget generateTimeCursor() {
    // 获取当前时间
    updateTimeCursor();
    double top = eachHeight * (currentHour);
    // 计算当前在该行的位置
    double left = eachWidth * (currentMinute / widget.splitSpan);

    return Positioned(
      top: top,
      left: left,
      child: Container(
        height: eachHeight,
        width: 3,
        color: Colors.red,
      ),
    );
  }

  Widget generateBackgroundGrid() {
    return Positioned(
      child: Column(
        children: [
          for (int i = 0; i < rowNum; i++)
            Expanded(
              child: Row(
                children: [
                  for (int j = 0; j < colNum; j++)
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromRGBO(196, 223, 255, 1),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget generateGuestureDetector() {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onPanDown: (details) {
          isSelecting = !isSelecting;

          //  按下的时候先清除上一次的选中状态
          for (int i = 0; i < rowNum; i++) {
            for (int j = 0; j < colNum; j++) {
              cellSelected[i][j] = false;
            }
          }

          // 计算按下的位置
          int row = (details.localPosition.dy / eachHeight).floor();
          int col = (details.localPosition.dx / eachWidth).floor();

          // 设置起始选中的格子
          startRow = row;
          startCol = col;

          // 更新选中状态
          if (row >= 0 &&
              row < rowNum &&
              col >= 0 &&
              col < colNum &&
              isSelecting) {
            cellSelected[row][col] = true;
          }

          // 通知刷新
          setState(() {});
        },
        onPanUpdate: (details) {
          if (!isSelecting) {
            return;
          }
          // 计算按下的位置
          int row = (details.localPosition.dy / eachHeight).floor();
          int col = (details.localPosition.dx / eachWidth).floor();

          // 更新选中状态
          if (row >= 0 &&
              row < rowNum &&
              col >= 0 &&
              col < colNum &&
              isSelecting) {
            // 实现算法实现跨行选中
            setCellSelected(row, col);
          }

          // 通知刷新
          setState(() {});
        },
        child: Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          color: Colors.transparent,
        ),
      );
    });
  }

  // 实现算法实现跨行选中
  setCellSelected(int row, int col) {
    // 如果原地选中，就不变
    if (startRow == row && startCol == col) {
      return;
    }

    // 清空
    for (int i = 0; i < rowNum; i++) {
      for (int j = 0; j < colNum; j++) {
        cellSelected[i][j] = false;
      }
    }

    if (row > startRow) {
      print("正向选中");
      // 将开始的那行选完
      print("startRow: $startRow, startCol: $startCol");
      print("row: $row, col: $col");

      for (int i = startCol; i < colNum; i++) {
        cellSelected[startRow][i] = true;
      }
      // 将中间的行选完
      for (int i = startRow + 1; i < row; i++) {
        for (int j = 0; j < colNum; j++) {
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
        for (int j = colNum - 1; j >= 0; j--) {
          cellSelected[i][j] = true;
        }
      }

      // 选中最后一行
      for (int i = colNum - 1; i >= col; i--) {
        cellSelected[row][i] = true;
      }
    }
  }
}
