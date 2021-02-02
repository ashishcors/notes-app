import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:notesapp/features/notes/domain/repositories/notes_repository.dart';

import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository repository;

  NotesBloc(this.repository) : super(null);

  NotesState get initialState => NotesInitial();

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    yield NotesLoading();
    if (event is GetNotes) {
      // try {
      //   yield* repository.fetchNotes().map((event) {
      //     print(event[1].message);
      //     return NotesLoaded(event);
      //   });
      // } catch (e) {
      //   yield NotesError(e.toString());
      // }
    }
  }
}
