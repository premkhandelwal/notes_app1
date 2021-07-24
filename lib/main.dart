import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app1/businessLogic/bloc/video_bloc.dart';
import 'package:notes_app1/businessLogic/cubit/checkbox_cubit.dart';
import 'package:notes_app1/repositories/firebase_notes_repo.dart';
import 'package:notes_app1/repositories/notes_repo.dart';
import 'package:notes_app1/businessLogic/bloc/notes_bloc.dart';
import 'package:notes_app1/repositories/sqflite_notes_repo.dart';
import 'package:notes_app1/repositories/video_events_repo.dart';
import 'package:notes_app1/repositories/video_repo.dart';
import 'package:notes_app1/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("essssssssssssssssssssssssss$e");
  }
  runApp(MyApp(
    sqfLiteRepository: SqfLiteNotesRepo(),
    videoRepository: SqfLiteRepository(),
    notesRepository: FirebaseNotesRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final NotesRepository notesRepository;
  final VideoRepository videoRepository;
  final SqfLiteNotesRepo sqfLiteRepository;
  const MyApp(
      {Key? key,
      required this.notesRepository,
      required this.videoRepository,
      required this.sqfLiteRepository})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotesBloc>(
          create: (_) => NotesBloc(
              notesRepository: notesRepository,
              sqfLiteRepository: sqfLiteRepository),
        ),
        BlocProvider<VideoBloc>(
          create: (_) => VideoBloc(videoRepository: videoRepository),
        ),
        BlocProvider<CheckboxCubit>(
          create: (_) => CheckboxCubit(),
        ),
      ],
      child: BlocProvider<NotesBloc>(
          create: (_) => NotesBloc(
              notesRepository: notesRepository,
              sqfLiteRepository: sqfLiteRepository),
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
