import 'package:flutter/material.dart';
 import 'package:flutter_movies/src/pages/homePage.dart';
import 'package:flutter_movies/src/pages/movies/singlePage.Dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) { 
          return HomePage();
        },
        'single' : (BuildContext context) {
          return SinglePage();
        }
      },
    );
  }
}

