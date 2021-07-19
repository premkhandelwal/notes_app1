import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app1/Repositories/firebase_notes_repo.dart';
import 'package:notes_app1/Repositories/notes_repo.dart';
import 'package:notes_app1/businessLogic/cubit/bloc/notes_bloc.dart';
import 'package:notes_app1/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(notesRepository: FirebaseNotesRepository(),));
}

class MyApp extends StatelessWidget {

  final NotesRepository notesRepository;
  const MyApp({Key? key, required this.notesRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
    create: (_)=>NotesBloc(notesRepository: notesRepository),
      child:MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(isDelete: false,),
    ));
  }
}
