import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app1/businessLogic/bloc/video_bloc.dart';
import 'package:notes_app1/businessLogic/cubit/checkbox_cubit.dart';
import 'package:notes_app1/data/dataProvidersql.dart';
import 'package:notes_app1/data/dataproviderFirebase.dart';
import 'package:notes_app1/data/videoPlayerfunctions.dart';
import 'package:notes_app1/repositories/notes_repo.dart';
import 'package:notes_app1/businessLogic/bloc/notes_bloc.dart';
import 'package:notes_app1/repositories/video_repo.dart';
import 'package:notes_app1/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  firebaseFirestore.settings.copyWith(persistenceEnabled: false);

  runApp(MyApp(
   videoRepository: VideoRepository(videoPlayerFunctions: VideoPlayerFunctions()),
    notesRepository: NotesRepository(dataProviderFirebase: DataProviderFirebase(),dataProviderSql: DataProviderSql()),
  ));
}

class MyApp extends StatelessWidget {
  final NotesRepository notesRepository;
  final VideoRepository? videoRepository;
  const MyApp(
      {Key? key,
      required this.notesRepository, this.videoRepository,
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotesBloc>(
          create: (_) => NotesBloc(
              notesRepository: notesRepository,

              ),
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
              notesRepository: notesRepository),
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
