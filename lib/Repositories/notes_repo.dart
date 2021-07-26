import 'dart:async';
import 'package:notes_app1/data/dataProvidersql.dart';
import 'package:notes_app1/data/dataproviderFirebase.dart';
import 'package:notes_app1/data/notes.dart';

class NotesRepository {
  final DataProviderFirebase? dataProviderFirebase;
  final DataProviderSql? dataProviderSql;

  NotesRepository(
      {required this.dataProviderFirebase, required this.dataProviderSql});

  Future<void> addNewNotes(Notes notes) async {
    dataProviderFirebase?.addNewNotes(notes);
    dataProviderSql?.addNewNotes(notes);
  }

  Future<void> updateExistingNotes(Notes notes) async {
    dataProviderFirebase?.updateExistingNotes(notes);
    dataProviderSql?.updateExistingNotes(notes);
  }

  Future<void> deleteNotes(List<String?> notes) async {
    dataProviderFirebase?.deleteNotes(notes);
    dataProviderSql?.deleteNotes(notes);
  }

  Future<List<Notes?>?>? fetchAllNotes() async {
    List<Notes?>? x = <Notes>[];

    print("In fetch notes 1");
try {
  
   x =await dataProviderFirebase?.fetchAllNotes();
} catch (e) {
  x = await dataProviderSql?.fetchAllNotes();
}

return x;
  }

  Future<List<Notes?>>? fetchDeletedNotes() {
    try {
      return dataProviderFirebase?.fetchDeletedNotes();
    } catch (e) {
      return dataProviderSql?.fetchDeletedNotes();
    }
  }

}
