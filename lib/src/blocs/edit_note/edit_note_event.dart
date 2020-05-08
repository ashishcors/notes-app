import 'package:equatable/equatable.dart';
import 'package:notesapp/src/models/note.dart';

abstract class EditNoteEvent extends Equatable {
  const EditNoteEvent();

  @override
  List<Object> get props => [];
}

class AddOrUpdateNote extends EditNoteEvent {
//  final Note note;
//
//  const AddOrUpdateNote({this.note});
//
//  @override
//  List<Object> get props => [note];
}

class DeleteNote extends EditNoteEvent {
//  final Note note;
//
//  const DeleteNote({this.note});
//
//  @override
//  List<Object> get props => [note];
}
