import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes_app1/repositories/notes_repo.dart';
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
    if (event is AddNote) {
      yield* _mapAddNotesToState(event);
    }
    else if(event is UpdateNote){
      yield* _mapUpdateNotesToState(event);
    }
    else if(event is FetchAllNotes || event is NotesInitial){
      final res = await notesRepository?.fetchAllNotes();
        yield NotesLoadSuccess(res);
    }else if(event is FetchDeletedNotes){
      final res = await notesRepository?.fetchDeletedNotes();
        yield NotesLoadSuccess(res);
    }
    else if(event is DeleteNotes){
       yield* _mapDeleteNotesToState(event);
    }
  }

  Stream<NotesState> _mapAddNotesToState(AddNote event) async* {
    notesRepository?.addNewNotes(event.note);
  }
  Stream<NotesState> _mapUpdateNotesToState(UpdateNote event) async* {
    notesRepository?.updateExistingNotes(event.note);
  }
Stream<NotesState> _mapDeleteNotesToState(DeleteNotes event) async* {
    notesRepository?.deleteNotes(event.notes);
  }




  @override
  void add(NotesEvent event) {
    super.add(event);
  }
}
