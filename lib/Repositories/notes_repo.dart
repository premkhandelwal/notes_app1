
import 'dart:async';

import 'package:notes_app1/data/notes.dart';


abstract class NotesRepository {
  Future<void> addNewNotes(Notes notes);

  
/* 
  Future<void> deleteNotes(Notes notes);

  Stream<List<Notes>> notess();

  Future<void> updateNotes(Notes notes); */
}