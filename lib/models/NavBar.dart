import 'package:MyMoto/screens/MeinProfil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Buttons.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(

      children: <Widget>[
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

                MotorradHelmButton(onPressed:  () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => MeinProfil()),);
                },
                ),
              ],
            ),
          ),
        ),
      ],

    );
  }
}
