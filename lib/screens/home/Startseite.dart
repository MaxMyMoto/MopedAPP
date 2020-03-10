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
         PreferredSize(
          preferredSize: Size.fromHeight(50),
            child: Container(
                  alignment: Alignment.bottomCenter,
                 decoration: new BoxDecoration (color: Color(0xff1e1e1e)),
                   child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.menu), onPressed:(){}, iconSize: 30,),
                           Text('Startseite', style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'texgyreadventors')),
                          IconButton(icon: Icon(Icons.home), onPressed:(){},iconSize: 30,),
                        ],)
       ),
        ),

       bottomNavigationBar:
       Stack(children: <Widget>[
        Positioned(
          child: Container(
          color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                 KostenButton(onPressed: () {
              print('tapped Me');
            },
            ),

                MapsButton(onPressed: () {
              print('tapped Me');
            },
            ),

                MotorradButton(onPressed: () {
              print('tapped Me');
            },
            ),
                StatsButton(onPressed: () {
              print('tapped Me');
            },
            ),

               MotorradHelmButton(onPressed: () {
              print('tapped Me');
            },
            ),
          ],
        ),
          ),
      ),
    ],
    ),


      body: Container(
       child:CustomScrollView(
         slivers: <Widget>[
           SliverAppBar(

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


