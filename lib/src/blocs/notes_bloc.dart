import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:notesapp/src/repositories/notes_repository.dart';

import './bloc.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository repository;

  NotesBloc(this.repository);

  @override
  NotesState get initialState => NotesInitial();

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    yield NotesLoading();
    if (event is GetNotes) {
      try {
        yield* repository.fetchNotes().map((event) {
          print(event[1].message);
          return NotesLoaded(event);
        });
      } catch (e) {
        yield NotesError(e.toString());
      }
    }
  }
}
