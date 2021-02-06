import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/utils/color_palette.dart';
import '../../../../core/widgets/blocking_progress.dart';
import 'edit_note_controller.dart';

class EditNotePage extends GetView<EditNoteController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () => controller.saveNote(),
        child: BlockingProgress(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: controller.color.value.forBg(Get.isDarkMode),
            body: SafeArea(
              child: NotePageLayout(controller),
            ),
            appBar: AppBar(
              backgroundColor: controller.color.value.forBg(Get.isDarkMode),
              elevation: 0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.palette_outlined),
                  onPressed: () => controller.openColorPicker(),
                ),
                Builder(
                  builder: (buildContext) => IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () => controller.deleteNote(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotePageLayout extends StatelessWidget {
  final _focusNode = FocusNode();
  final EditNoteController controller;

  NotePageLayout(this.controller);

  void _handleKeyEvent(RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller.titleController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration.collapsed(hintText: 'Title'),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: controller.messageController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration.collapsed(hintText: 'Message'),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
