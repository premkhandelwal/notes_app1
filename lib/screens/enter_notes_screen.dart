import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app1/businessLogic/cubit/bloc/notes_bloc.dart';
import 'package:notes_app1/data/notes.dart';

TextEditingController titleController = new TextEditingController();
TextEditingController contentController = new TextEditingController();

class EnterNotesScreen extends StatefulWidget {
  final Notes? note;
  final bool isUpdate;

  const EnterNotesScreen({
    Key? key,
    this.note,
    required this.isUpdate,
  }) : super(key: key);

  @override
  _EnterNotesScreenState createState() => _EnterNotesScreenState();
}

class _EnterNotesScreenState extends State<EnterNotesScreen> {
  @override
  void initState() {
    if (widget.isUpdate) {
      if (widget.note!.title != null) {
        titleController.text = widget.note!.title!;
        contentController.text = widget.note!.content!;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            controller: titleController,
            onTap: () {},
            decoration: InputDecoration(
              labelText: "Title",
            ),
            // initialValue: "Title",
          ),
          TextFormField(
            maxLines: 3,
            controller: contentController,
            onTap: () {},
            decoration: InputDecoration(
              labelText: "Content",
            ),
            // initialValue: "Title",
          ),
          ElevatedButton(
            onPressed: () {
              if (widget.isUpdate) {
                context.read<NotesBloc>().add(UpdateNote(Notes(
                  isDeleted: false,
                  id: widget.note?.id,
                    content: contentController.text,
                    title: titleController.text)));
              } else {
                context.read<NotesBloc>().add(AddNote(Notes(
                  isDeleted: false,
                    content: contentController.text,
                    title: titleController.text)));
              }
              
              //  context.<NotesBloc>().add(TodoAdded(Todo(_task, note: _note)));
            },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
