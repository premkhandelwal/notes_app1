import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app1/Repositories/notes_repo.dart';
import 'package:notes_app1/data/notes.dart';

class FirebaseNotesRepository implements NotesRepository {
  final notesCollection = FirebaseFirestore.instance.collection('notes');
  @override
  Future<void> addNewNotes(Notes notes) {
    return notesCollection
        .add({
          'title': "${notes.title}",
          'content': "${notes.content}",
          'isDeleted': false
        })
        .then((value) => print("Note Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Future<void> updateExistingNotes(Notes notes) {
    // FirebaseFirestore.instance.collection('collection_Name').doc('doc_Name').collection('collection_Name').doc(code.documentId).update({'redeem': true});

    return notesCollection
        .doc("${notes.id}")
        .update({
          'title': "${notes.title}",
          'content': "${notes.content}",
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  List<Notes?> fetchAllNotes() {
    List<Notes?> listNotes = [];

    notesCollection.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.id);
        if (result.data()["isDeleted"] == false) {
          listNotes.add(Notes(
              id: result.id,
              isDeleted: false,
              title: result.data()["title"],
              content: result.data()["content"]));
        }
      });
    });
    return listNotes;
  }

  @override
  Future<void> deleteNotes(List<String?> notes) async {
    for (var i = 0; i < notes.length; i++) {
      return notesCollection
          .doc("${notes[i]}")
          .update({
            'isDeleted': true,
          })
          .then((value) => print("User Deleted"))
          .catchError((error) => print("Failed to delete user: $error"));
    }
  }

  @override
  List<Notes?> fetchDeletedNotes() {
    List<Notes?> listNotes = [];

    notesCollection.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.id);
        if (result.data()["isDeleted"] == true) {
          listNotes.add(Notes(
              id: result.id,
              isDeleted: false,
              title: result.data()["title"],
              content: result.data()["content"]));
        }
      });
    });
    return listNotes;
  }
}
