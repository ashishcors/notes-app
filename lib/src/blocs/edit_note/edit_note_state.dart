import 'package:equatable/equatable.dart';

abstract class EditNoteState extends Equatable {
  const EditNoteState();

  @override
  List<Object> get props => [];
}

class EditNoteInitial extends EditNoteState {
  const EditNoteInitial();
}

class EditNoteProcessing extends EditNoteState {
  const EditNoteProcessing();
}

class NoteSaved extends EditNoteState {
  const NoteSaved();
}

class NoteDeleted extends EditNoteState {
  const NoteDeleted();
}

class NoteEditingError extends EditNoteState {
  final String message;

  const NoteEditingError(this.message);

  @override
  List<Object> get props => [message];
}
