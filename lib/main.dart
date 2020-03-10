import 'package:flutter/material.dart';
import 'package:MyMoto/screens/Startseite.dart';


void main() => runApp(MyMoto());

class MyMoto extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyMoto',
            debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xff333333)
        ),
        home: HomeScreen(),
    );
  }
}




