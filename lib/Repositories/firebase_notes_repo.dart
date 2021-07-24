import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app1/repositories/notes_repo.dart';
import 'package:notes_app1/data/notes.dart';

class FirebaseNotesRepository implements NotesRepository {
  final notesCollection = FirebaseFirestore.instance.collection('notes');

  @override
  Future<void> addNewNotes(Notes notes, BuildContext context) async {
    print("here1");

    try {
       notesCollection.add({
        'title': "${notes.title}",
        'content': "${notes.content}",
        'isVideoAdded': notes.isVideoAdded,
        'videoLink': "${notes.videoLink}",
        'isDeleted': false
      }).then((value) =>  ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Added Successfully"))));

    } catch (e) {
      print("cell$e");
      throw SocketException("No Inet");
    }
  }

  @override
  Future<void> updateExistingNotes(Notes notes) {
    // FirebaseFirestore.instance.collection('collection_Name').doc('doc_Name').collection('collection_Name').doc(code.documentId).update({'redeem': true});

    return notesCollection
        .doc("${notes.id}")
        .update({
          'title': "${notes.title}",
          'content': "${notes.content}",
          'isVideoAdded': "${notes.isVideoAdded}",
          'videoLink': "${notes.videoLink}",
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Future<List<Notes?>> fetchAllNotes() async {
    List<Notes?> listNotes = [];

    await notesCollection.get().then((querySnapshot) {
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
    });
    /* */
    if (listNotes.isEmpty) {
      throw SocketException("No Internet");
    }
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
    return listNotes;
  }
}
