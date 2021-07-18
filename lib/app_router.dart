
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app1/screens/enter_notes_screen.dart';
import 'package:notes_app1/screens/home_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case "/second":
        return MaterialPageRoute(builder: (_) => EnterNotesScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
