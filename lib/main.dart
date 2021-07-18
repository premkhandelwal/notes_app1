import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app1/Repositories/firebase_notes_repo.dart';
import 'package:notes_app1/app_router.dart';
import 'package:notes_app1/businessLogic/cubit/bloc/notes_bloc.dart';
import 'package:notes_app1/businessLogic/cubit/connection_cubit.dart';
import 'package:notes_app1/screens/enter_notes_screen.dart';
import 'package:notes_app1/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
   final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      
        BlocProvider<NotesBloc>(create: (ctx) => NotesBloc(notesRepository: FirebaseNotesRepository())),
      ],
      child:MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: appRouter.onGenerateRoute,
    ));
  }
}
