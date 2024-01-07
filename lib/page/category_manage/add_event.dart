import 'package:flex_color_picker/flex_color_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:time_tracker/common/controller/category_controller.dart';
import 'package:time_tracker/common/dao/event_dao.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/common/model/event_category.dart';
import 'package:time_tracker/common/utils/utils.dart';
import 'package:time_tracker/page/category_manage/widget/inputField.dart';

class AddEventWidget extends StatelessWidget {
  final CategoryController categoryController = Get.find<CategoryController>();
  final Rx<EventCategory?> selectCategory = Rx<EventCategory?>(null);
  final Rx<String> eventName = Rx<String>("");
  final Rx<Color> eventColor = Rx<Color>(Colors.red);

  AddEventWidget({super.key});

  void addEvent() async {
    EventCategory? category = selectCategory.value;
    if (category == null) {
      return;
    }

    Event? event = await EventDao.addEvent(
        eventName.value, category.id!, HexColor.toHex(eventColor.value));
    if (event != null) {
      // 添加成功
      Get.snackbar("添加成功", "添加事件成功");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addEvent();
          // 关闭弹窗
          Get.back();
        },
        child: const Icon(Icons.check),
      ),
      body: Obx(() => _buildView()),
    );
  }

  Padding _buildView() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInput(
            title: "事件名称",
            onChanged: (value) {
              eventName.value = value;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("分类选择"),
          const SizedBox(
            height: 10,
          ),
          //下拉框
          _buildDropDownButton(),
          const SizedBox(
            height: 10,
          ),
          const Text("事件颜色"),
          _buildColorPicker()
        ],
      ),
    );
  }

  Widget _buildDropDownButton() {
    // 构建显示数据
    List<DropdownMenuItem<EventCategory>> items = [];
    for (var element in categoryController.categories) {
      items.add(DropdownMenuItem<EventCategory>(
        value: element,
        child: Text(element.name),
      ));
    }

    return Obx(() => DropdownButton<EventCategory>(
          //设置下拉框中的值
          items: items,
          //设置默认显示的值,要考虑列表为空的情况
          value: selectCategory.value,
          //设置下拉框的值改变时的回调
          onChanged: (EventCategory? value) {
            selectCategory.value = value;
          },
        ));
  }

  ColorPicker _buildColorPicker() {
    return ColorPicker(
        // 设置中文显示
        pickerTypeLabels: const <ColorPickerType, String>{
          ColorPickerType.both: '全部',
          ColorPickerType.primary: '主色',
          ColorPickerType.accent: '强调',
          ColorPickerType.bw: '黑白',
          ColorPickerType.custom: '自定义',
          ColorPickerType.wheel: '色盘',
        },
        pickersEnabled: const <ColorPickerType, bool>{
          ColorPickerType.both: true,
          ColorPickerType.primary: true,
          ColorPickerType.accent: true,
          ColorPickerType.bw: false,
          ColorPickerType.custom: true,
          ColorPickerType.wheel: true,
        },
        onColorChanged: (Color color) {
          eventColor.value = color;
        },
        color: Colors.red);
  }
}
