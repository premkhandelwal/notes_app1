import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app1/businessLogic/bloc/notes_bloc.dart';
import 'package:notes_app1/data/notes.dart';

TextEditingController titleController = new TextEditingController(text: "");
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
    titleController.text = "";
    contentController.text = "";
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
      appBar: AppBar(
        title: TextFormField(
          controller: titleController,
          style: TextStyle(color: Colors.white, fontSize: 20),
          onTap: () {},
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "Enter Title",
            suffixIcon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            hintStyle: TextStyle(color: Colors.white, fontSize: 20),
            fillColor: Colors.amber,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          // initialValue: "Title",cxc
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(border: Border.all()),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: contentController,
                onTap: () {},
                cursorColor: Colors.deepPurpleAccent,
                cursorHeight: 30,
                style: TextStyle(fontSize: 19),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                // initialValue: "Title",
              ),
            ),
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: widget.isUpdate
                      ? Text("Update Note")
                      : Text("Add Note")));
              //  context.<NotesBloc>().add(TodoAdded(Todo(_task, note: _note)));
            },
            child: widget.isUpdate ? Text("Update Note") : Text("Add Note"),
          )
        ],
      ),
    );
  }
}
