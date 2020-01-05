import 'package:attendances/screens/login_pages.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Color(0xFFFFC355),
      ),
      home: LoginPages(),
    );
  }
}

