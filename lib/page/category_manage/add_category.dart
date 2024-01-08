
import 'package:flutter/material.dart';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/dao/category_dao.dart';
import 'package:time_tracker/common/model/event_category.dart';
import 'package:time_tracker/common/utils/utils.dart';
import 'package:time_tracker/page/category_manage/widget/input_field.dart';

class AddCategoryEventPage extends StatelessWidget {
  final Rx<Color> pickeColor = Rx<Color>(Colors.red);
  final Rx<String> inputCategoryName = Rx<String>("");
  AddCategoryEventPage({Key? key}) : super(key: key);

  void addCategory() async {
    if (inputCategoryName.value.isEmpty) {
      Get.snackbar("添加失败", "分类名称不能为空");
      return;
    }

    EventCategory? eventCategory = await CategoryDao.addCategory(
        inputCategoryName.value, HexColor.toHex(pickeColor.value));

    if (eventCategory != null) {
      Get.snackbar("添加成功", "添加分类成功");
    } else {
      Get.snackbar("添加失败", "添加分类失败");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              TextInput(
                title: "分类名称",
                onChanged: (value) {
                  inputCategoryName.value = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("分类颜色"),
              const SizedBox(
                height: 10,
              ),
              _buildColorPicker(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addCategory();
            Get.back();
          },
          child: const Icon(Icons.check),
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
          pickeColor.value = color;
        },
        color: Colors.red);
  }
}
