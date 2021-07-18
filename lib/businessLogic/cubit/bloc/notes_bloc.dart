import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes_app1/Repositories/notes_repo.dart';
import 'package:notes_app1/data/notes.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository? notesRepository;

  NotesBloc({this.notesRepository}) : super(NotesInitial());

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is AddNotes) {
      yield* _mapAddNotesToState(event);
    }
  }

  Stream<NotesState> _mapAddNotesToState(AddNotes event) async* {
    notesRepository?.addNewNotes(event.note);
  }

  @override
  void add(NotesEvent event) {
    super.add(event);
  }
}
