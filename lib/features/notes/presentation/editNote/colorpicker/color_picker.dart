import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/color_palette.dart';
import 'color_picker_controller.dart';

typedef OnColorSelected = Function(Color);

class ColorPicker extends GetView<ColorPickerController> {
  ColorPicker(Color selectedColor, OnColorSelected onNewColorSelected) {
    Get.put<ColorPickerController>(
        ColorPickerController(selectedColor, onNewColorSelected));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        padding: EdgeInsets.all(8),
        color: Get.theme.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Pick color", style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              shrinkWrap: true,
              itemBuilder: (context, i) => _item(ColorPalette.NOTES_COLOR[i]),
              itemCount: ColorPalette.NOTES_COLOR.length,
            ),
            MaterialButton(
              minWidth: double.infinity,
              color: Get.theme.accentColor,
              onPressed: () => controller.onSelectPressed(),
              child: Text(
                'SELECT',
                style: TextStyle(color: Get.theme.backgroundColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _item(Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => controller.setSelectedColor(color),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.forBg(Get.isDarkMode),
          ),
          child: Obx(
            () => Visibility(
              visible: controller.selectedColor.value.value == color.value,
              child: Icon(
                Icons.check,
                color: Get.theme.accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
