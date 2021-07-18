import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app1/Repositories/notes_repo.dart';
import 'package:notes_app1/data/notes.dart';

class FirebaseNotesRepository implements NotesRepository{
      final notesCollection = FirebaseFirestore.instance.collection('notes');
  @override
  Future<void> addNewNotes(Notes notes) {
    return notesCollection
          .add({
            'title': "${notes.title}", // John Doe
            'content': "${notes.content}",// 42
          })
          .then((value) => print("Note Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  
 

}