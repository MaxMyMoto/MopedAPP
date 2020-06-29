
import 'package:MyMoto/models/Drawer.dart';
import 'package:MyMoto/models/MenuItem.dart';
import 'package:MyMoto/models/NavBar.dart';
import 'package:MyMoto/models/sign_in.dart';
import 'package:MyMoto/screens/Startseite.dart';
import 'package:flutter/material.dart';
import 'package:MyMoto/models/Buttons.dart';
import 'package:MyMoto/screens/login_page.dart';



class MeinKonto extends StatefulWidget {
  @override
  _MeinKontoState createState() => _MeinKontoState();
}

class _MeinKontoState extends State<MeinKonto> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Color(0xff1e1e1e),
        centerTitle: true,
        title: Text("Mein Konto", style: TextStyle(fontFamily: 'texgyreadventors', color: Colors.white,),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.home, color: Colors.white,), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);}, iconSize: 25,)
        ],
      ),



      drawer: Drawer(child:
      Seitenleiste()
      ),


      bottomNavigationBar:
      NavBar(),

      body: Container(
        color: Color(0xff272727),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                email,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
                },
                color: Color(0xFFe71e2e),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
