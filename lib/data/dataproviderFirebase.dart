import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app1/data/notes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataProviderFirebase {
  Database? _database;

  final notesCollection = FirebaseFirestore.instance.collection('notes');

  Future<void> addNewNotes(Notes notes) async {
    notesCollection.add({
      'title': "${notes.title}",
      'content': "${notes.content}",
      'isVideoAdded': notes.isVideoAdded,
      'videoLink': "${notes.videoLink}",
      'isDeleted': false
    });
  }

  Future<void> updateExistingNotes(Notes notes) async {
    // FirebaseFirestore.instance.collection('collection_Name').doc('doc_Name').collection('collection_Name').doc(code.documentId).update({'redeem': true});

    notesCollection.doc("${notes.id}").update({
      'title': "${notes.title}",
      'content': "${notes.content}",
      'isVideoAdded': "${notes.isVideoAdded}",
      'videoLink': "${notes.videoLink}",
    });
  }

  Future<List<Notes?>> fetchAllNotes() async {
  
    List<Notes?> listNotes = [];

    var x = notesCollection.get(GetOptions(source: Source.server));

    // x.catchError((e) => throw SocketException("No Internet Connection"));
    x.then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if (result.data()["isDeleted"] == false) {
          listNotes.add(Notes(
              videoLink: result.data()["videoLink"],
              id: result.id,
              isDeleted: false,
              isVideoAdded: result.data()["isVideoAdded"],
              title: result.data()["title"],
              content: result.data()["content"]));
        }
      });
      return listNotes;
    }).catchError((e) {
      throw SocketException("No Internet Connection");
    });
    throw SocketException("No Internet Connection");
  }


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

  Future<List<Notes?>> fetchDeletedNotes() async {
    List<Notes?> listNotes = [];

    await notesCollection.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if (result.data()["isDeleted"] == true) {
          listNotes.add(Notes(
              videoLink: result.data()["videoLink"],
              id: result.id,
              isDeleted: false,
              isVideoAdded: result.data()["isVideoAdded"],
              title: result.data()["title"],
              content: result.data()["content"]));
        }
      });
    });
    if (listNotes.isEmpty) {
      throw SocketException("No Internet Connection");
    }

    return listNotes;
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDb();
      return _database;
    }
  }

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = "${documentDirectory.path}/Notes.db";
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE Notes("
        "Note_ID INTEGER PRIMARY KEY,"
        "Firebase_UID TEXT,"
        "Note_Title TEXT,"
        "Note_Content TEXT,"
        "Video_Link TEXT,"
        "isVideoAdded BIT,"
        "isDeleted BIT"
        ")",
      );
    });
  }
}
