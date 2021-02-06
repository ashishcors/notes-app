import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/color_palette.dart';
import '../../../../../routing/app_pages.dart';
import '../../../domain/entities/note.dart';

class NoteView extends StatelessWidget {
  final Note _note;

  NoteView(this._note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.EDIT_NOTE, arguments: _note),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(_note.color ?? ColorPalette.NOTE_DEFAULT.value)
              .forBg(Get.isDarkMode),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 2),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Text(
                    _note.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Visibility(
                  child: Icon(Icons.push_pin, size: 12),
                  visible: _note.isPinned ?? false,
                ),
              ],
            ),
            Text(
              _note.message,
              overflow: TextOverflow.fade,
              softWrap: true,
              maxLines: 15,
            ),
          ],
        ),
      ),
    );
  }
}
