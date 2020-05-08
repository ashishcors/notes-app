import 'package:equatable/equatable.dart';
import 'package:notesapp/src/models/note.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class GetNotes extends NotesEvent {}
