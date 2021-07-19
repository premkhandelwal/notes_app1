
import 'dart:async';

import 'package:notes_app1/data/notes.dart';


abstract class NotesRepository {
  Future<void> addNewNotes(Notes notes);
  Future<void> updateExistingNotes(Notes notes);
 Future<List<Notes?>> fetchAllNotes();
  Future<List<Notes?>> fetchDeletedNotes();
   Future<void> deleteNotes(List<String?> notes);
  
/* 
  Future<void> deleteNotes(Notes notes);

  Stream<List<Notes>> notess();

  Future<void> updateNotes(Notes notes); */
}