import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/features/notes/domain/entities/note.dart';
import 'package:notesapp/features/notes/domain/usecases/add_note_use_case.dart';
import 'package:notesapp/features/notes/domain/usecases/delete_note_use_case.dart';
import 'package:notesapp/features/notes/domain/usecases/update_note_use_case.dart';

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

  var note =
      ((Get.arguments ?? Note(null, "", "", Colors.white.value)) as Note).obs;

  final titleController = TextEditingController();
  final messageController = TextEditingController();

  final color = Colors.white.obs;

  @override
  void onInit() {
    super.onInit();
    titleController.text = note.value.title;
    messageController.text = note.value.message;
    color.value = Color(note.value.color ?? Colors.white.value);
  }

  deleteNote() async {
    isLoading.value = true;
    final result = await _deleteNoteUseCase(note.value.noteId);
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

  saveNote() async {
    isLoading.value = true;
    final title = titleController.text;
    final message = messageController.text;
    final mColor = color.value.value;

    if (title.isEmpty && message.isEmpty) return;

    final noteId = note.value.noteId;

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
  }
}
