import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/color_palette.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/add_note_use_case.dart';
import '../../domain/usecases/delete_note_use_case.dart';
import '../../domain/usecases/update_note_use_case.dart';
import 'colorpicker/color_picker.dart';

class EditNoteController extends GetxController {
  final AddNoteUseCase _addNoteUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;

  EditNoteController(
    this._addNoteUseCase,
    this._updateNoteUseCase,
    this._deleteNoteUseCase,
  );

  final isLoading = false.obs;

  final note = ((Get.arguments ??
      Note(null, "", "", ColorPalette.NOTE_DEFAULT.value)) as Note);

  final titleController = TextEditingController();
  final messageController = TextEditingController();

  final color = Colors.white.obs;

  @override
  void onInit() {
    super.onInit();
    titleController.text = note.title;
    messageController.text = note.message;
    color.value = Color(note.color ?? ColorPalette.NOTE_DEFAULT.value);
  }

  void deleteNote() async {
    isLoading.value = true;
    final result = await _deleteNoteUseCase(note.noteId);
    result.fold(
      (value) {
        isLoading.value = false;
        Get.back();
      },
      (exception) {
        isLoading.value = false;
        Get.snackbar("Error!", exception.toString());
      },
    );
  }

  Future<bool> saveNote() async {
    final title = titleController.text;
    final message = messageController.text;
    final mColor = color.value.value;

    if (_isContentUnChange(title, message, mColor)) {
      Get.back();
      return true;
    }

    if (title.isEmpty && message.isEmpty) {
      Get.defaultDialog(
          title: "Delete note?",
          middleText: "Your note is empty. Would you like to delete this?",
          textConfirm: "Delete",
          confirmTextColor: Get.theme.backgroundColor,
          textCancel: "Keep editing",
          onConfirm: () {
            Get.back();
            deleteNote();
          });
      return false;
    }

    final noteId = note.noteId;

    isLoading.value = true;
    final result = (noteId == null)
        ? await _addNoteUseCase(AddNoteParam(title, message, mColor))
        : await _updateNoteUseCase(Note(noteId, title, message, mColor));

    result.fold(
      (value) {
        isLoading.value = false;
        Get.back();
      },
      (exception) {
        isLoading.value = false;
        Get.snackbar("Error!", exception.toString());
      },
    );
    return false;
  }

  bool _isContentUnChange(String title, String message, int mColor) {
    return title == note.title &&
        message == note.message &&
        mColor == note.color;
  }

  openColorPicker() {
    Get.dialog(ColorPicker(color.value, (newColor) => color.value = newColor));
  }
}
