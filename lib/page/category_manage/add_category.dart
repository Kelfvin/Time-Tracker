import 'package:flutter/material.dart';

import 'package:flex_color_picker/flex_color_picker.dart';

class TextInput extends StatelessWidget {
  final String title;
  const TextInput({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("分类名称"),
        SizedBox(
          height: 10,
        ),
        TextField(
          // 设置高度

          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

class AddCategoryEventPage extends StatelessWidget {
  const AddCategoryEventPage({Key? key}) : super(key: key);

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
              const TextInput(
                title: "分类名称",
              ),
              const TextInput(
                title: "标签",
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("分类颜色"),
              const SizedBox(
                height: 10,
              ),
              ColorPicker(
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
                    print(color);
                  },
                  color: Colors.red),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("添加分类");
          },
          child: const Icon(Icons.check),
        ));
  }
}
