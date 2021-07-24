import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:notes_app1/repositories/notes_repo.dart';
import 'package:notes_app1/data/notes.dart';
import 'package:notes_app1/repositories/sqflite_notes_repo.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository? notesRepository;
  final SqfLiteNotesRepo? sqfLiteRepository;

  NotesBloc({this.notesRepository, this.sqfLiteRepository})
      : super(NotesInitial());

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is AddNote) {
      yield* _mapAddNotesToState(event);
    } else if (event is UpdateNote) {
      yield* _mapUpdateNotesToState(event);
    } else if (event is FetchAllNotes || event is NotesInitial) {
      var res;
      try {

        res = await notesRepository?.fetchAllNotes();
      } catch (_) {
        print("yoyo");
        res = await sqfLiteRepository?.fetchAllNotes();
        

      } 
      finally{
        yield NotesLoadSuccess(res);

      }
    } else if (event is FetchDeletedNotes) {
      var res;
      try {
        res = await notesRepository?.fetchDeletedNotes();
      } on SocketException catch (_) {
        res = await sqfLiteRepository?.fetchDeletedNotes();
      } finally {
        yield NotesLoadSuccess(res);
      }
    } else if (event is DeleteNotes) {
      yield* _mapDeleteNotesToState(event);
    }
  }

  Stream<NotesState> _mapAddNotesToState(AddNote event) async* {
    try {
      notesRepository?.addNewNotes(event.note,event.context);
      
    } catch (e) {
      print("Tera fittor");
      sqfLiteRepository?.addNewNotes(event.note,event.context);
    }
  }

  Stream<NotesState> _mapUpdateNotesToState(UpdateNote event) async* {
    notesRepository?.updateExistingNotes(event.note);
    sqfLiteRepository?.updateExistingNotes(event.note);
  }

  Stream<NotesState> _mapDeleteNotesToState(DeleteNotes event) async* {
    notesRepository?.deleteNotes(event.notes);
    sqfLiteRepository?.deleteNotes(event.notes);
  }

  @override
  void add(NotesEvent event) {
    super.add(event);
  }
}
