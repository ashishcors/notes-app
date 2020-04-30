import 'package:equatable/equatable.dart';
import 'package:notesapp/src/models/note.dart';

abstract class NotesState extends Equatable {
  const NotesState();
}

class NotesInitial extends NotesState {
  const NotesInitial();
  @override
  List<Object> get props => [];
}

class NotesLoading extends NotesState {
  const NotesLoading();
  @override
  List<Object> get props => [];
}

class NotesLoaded extends NotesState {
  final List<Note> noteList;
  const NotesLoaded(this.noteList);
  @override
  List<Object> get props => [];
}

class NotesError extends NotesState {
  final String message;
  const NotesError(this.message);
  @override
  List<Object> get props => [];
}
