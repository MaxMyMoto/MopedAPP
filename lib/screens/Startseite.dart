import 'package:MyMoto/models/Drawer.dart';
import 'package:MyMoto/models/MenuItem.dart';
import 'package:MyMoto/models/NavBar.dart';
import 'package:MyMoto/models/sign_in.dart';
import 'package:MyMoto/screens/MeinKonto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:MyMoto/models/Buttons.dart';




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:
     AppBar(
       backgroundColor: Color(0xff1e1e1e),
       centerTitle: true,
       title: Text("Startseite", style: TextStyle(fontFamily: 'texgyreadventors', color: Colors.white,),),
       actions: <Widget>[
         IconButton(icon: Icon(Icons.home, color: Colors.white,), onPressed: null, iconSize: 25,)
       ],
     ),


      drawer: Drawer(child:
        Seitenleiste()
      ),

      bottomNavigationBar:
        NavBar(),



    body: Container(
          child:CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Color(0xff333333),
                automaticallyImplyLeading: false,
                title:  Text(
                  'TEST',
                ),

                floating: true,
                centerTitle: true,
                elevation: 10.0,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(),
              ),
            ],
          )) ,
    );
  }
}

