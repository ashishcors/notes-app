import 'package:equatable/equatable.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class GetNotes extends NotesEvent {
  const GetNotes();

  @override
  List<Object> get props => [];
}
