import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app1/businessLogic/cubit/bloc/notes_bloc.dart';
import 'package:notes_app1/data/notes.dart';

class EnterNotesScreen extends StatelessWidget {
  const EnterNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        new TextEditingController();
    TextEditingController contentController =
        new TextEditingController();

      CollectionReference notes = FirebaseFirestore.instance.collection('notes');
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      
      return notes
          .add({
            'title': "${titleController.text}", // John Doe
            'content': "${contentController.text}",// 42
          })
          .then((value) => print("Note Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(

            controller: titleController,
            onTap: () {
              
            },
            decoration: InputDecoration(labelText: "Title",),
            // initialValue: "Title",
          ),
            TextFormField(
maxLines: 3,
            controller: contentController,
            onTap: () {
              
            },
            decoration: InputDecoration(labelText: "Content",),
            // initialValue: "Title",
          ),
          ElevatedButton(onPressed: (){
            context.read<NotesBloc>().add(AddNotes(Notes(content: contentController.text,title: titleController.text)));
            //  context.<NotesBloc>().add(TodoAdded(Todo(_task, note: _note)));
          },child: Text("Submit"),)
        ],
      ),
    );
  }
}
