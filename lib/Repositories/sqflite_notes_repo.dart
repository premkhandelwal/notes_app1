import 'dart:io';

import 'package:notes_app1/data/notes.dart';
import 'package:notes_app1/repositories/notes_repo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqfLiteNotesRepo implements NotesRepository {
  Database? _database;

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

  @override
  Future<void> addNewNotes(Notes notes) async {
    print("I cam heree");

    final db = await database;
    var res = await db!.rawInsert(
      "INSERT INTO Notes(Note_Title,Note_Content,Video_Link,isVideoAdded,isDeleted)"
      " VALUES ('${notes.title}','${notes.content}','${notes.videoLink}','${notes.isVideoAdded}','false')",
    );
    print("resf${res}");
  }

  @override
  Future<void> updateExistingNotes(Notes notes) async {
    final db = await database;
    await db!.rawUpdate(
      "UPDATE Notes SET Note_Title = ${notes.title},Note_Content = ${notes.content},Video_Link = ${notes.videoLink},isVideoAdded = ${notes.isVideoAdded} WHERE Firebase_UID = ${notes.id}",
    );
  }

  @override
  Future<void> deleteNotes(List<String?> notes) async {
    final db = await database;
    for (var i = 0; i < notes.length; i++) {
      await db!.rawDelete(
        "UPDATE Notes SET isDeleted =  TRUE where Firebase_UID = ${notes[i]}",
      );
    }
  }

  @override
  Future<List<Notes?>> fetchAllNotes() async {
    //print("I am heree");
    final db = await database;
    var res = await db!.query("Notes");
    //print(res);
    List<Notes> list =
        res.isNotEmpty ? res.map((c) => Notes.fromMap(c)).toList() : [];
    //print(list);
    return list;
  }

  @override
  Future<List<Notes?>> fetchDeletedNotes() async {
    final db = await database;
    var res = await db!.rawQuery("SELECT * FROM Notes WHERE isDeleted=1");
    List<Notes> list =
        res.isNotEmpty ? res.map((c) => Notes.fromMap(c)).toList() : [];
    return list;
  }
}
