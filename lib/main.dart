import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app1/businessLogic/bloc/video_bloc.dart';
import 'package:notes_app1/businessLogic/cubit/checkbox_cubit.dart';
import 'package:notes_app1/repositories/firebase_notes_repo.dart';
import 'package:notes_app1/repositories/notes_repo.dart';
import 'package:notes_app1/businessLogic/bloc/notes_bloc.dart';
import 'package:notes_app1/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    notesRepository: FirebaseNotesRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final NotesRepository notesRepository;
  const MyApp({Key? key, required this.notesRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotesBloc>(
          create: (_) => NotesBloc(notesRepository: notesRepository),
        ),
        BlocProvider<VideoBloc>(
          create: (_) => VideoBloc(),
        ),
        BlocProvider<CheckboxCubit>(
          create: (_) => CheckboxCubit(),
        ),
      ],
      child: BlocProvider<NotesBloc>(
          create: (_) => NotesBloc(notesRepository: notesRepository),
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeScreen(
              isDelete: false,
            ),
          )),
    );
  }
}
