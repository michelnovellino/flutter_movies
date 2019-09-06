import 'package:flutter/material.dart';
import 'package:flutter_movies/src/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) { 
          return HomePage();
        }
      },
    );
  }
}

