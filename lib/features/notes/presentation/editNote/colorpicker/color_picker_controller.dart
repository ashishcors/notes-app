import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'color_picker.dart';

class ColorPickerController extends GetxController {
  Rx<Color> selectedColor;
  OnColorSelected _onNewColorSelected;

  ColorPickerController(Color selectedColor, onNewColorSelected) {
    this.selectedColor = selectedColor.obs;
    this._onNewColorSelected = onNewColorSelected;
  }

  setSelectedColor(Color color) {
    selectedColor.value = color;
  }

  onSelectPressed() {
    _onNewColorSelected(selectedColor.value);
    Get.back();
  }
}
