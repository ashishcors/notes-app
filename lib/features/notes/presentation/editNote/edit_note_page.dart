import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notesapp/features/notes/presentation/editNote/edit_note_controller.dart';

class EditNotePage extends GetView<EditNoteController> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: SafeArea(
          child: NotePageLayout(controller),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () => controller.saveNote(),
        ),
        appBar: AppBar(
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.image),
              onPressed: () => {},
            ),
            Builder(
              builder: (buildContext) => IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => controller.deleteNote(),
              ),
            ),
          ],
        ),
      ),
      Obx(
        () => Visibility(
          visible: controller.isLoading.value,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(.1)),
          ),
        ),
      ),
    ]);
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
