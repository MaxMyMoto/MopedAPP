import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:MyMoto/models/sign_in.dart';
import 'package:MyMoto/screens/NewUserName.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Startseite.dart';
final databaseReference = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _neworold = TextEditingController();
  final _geb = TextEditingController();
  TextEditingController _date = new TextEditingController();
  final _age=  TextEditingController();
  FirebaseUser user;
  String error;
  //.

  void setUser(FirebaseUser user) {
    setState(() {
      this.user = user;
      this.error = null;
    });
  }

  void setError(e) {
    setState(() {
      this.user = null;
      this.error = e.toString();
    });
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _neworold.dispose();
    super.dispose();

    _date.dispose();
    super.dispose();
    _age.dispose();
    super.dispose();
  }
  var myFormat = DateFormat('yyyy-MM-dd-');
void _getGeburtsdatum() async {
  var firebaseUser = await FirebaseAuth.instance.currentUser();
  Firestore.instance.collection("Users").document(firebaseUser.uid).get().then((value){
    _geb.text = value.data['GeburtsdatumRechnen'];
   _alterBerechnen(value.data['GeburtsdatumRechnen']);
  });
}
  void _alterBerechnen(String string){
    final Geburtstag = DateTime.parse(string.toString());
    final Jetzt = DateTime.now();

    final age = Jetzt.difference(Geburtstag).inDays;
    final age1 = age/365;
    final age2 = age1.toInt();
    _updateAlter(age2.toString());
  }

  void _updateAlter (String string) async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
        .updateData({

      'Alter': string,
    });
  }

  @override
  void initState() {
    super.initState();


    FirebaseAuth.instance.currentUser().then(setUser).catchError(setError);



  Timer(Duration(seconds: 2), () =>

        signInWithGoogle().whenComplete(() {

_UserStatus();
_getGeburtsdatum();

        } ),

        );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff333333)
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/image/LogoMyMoto1.png"),
                        radius: 50.0,
                       backgroundColor: Colors.transparent,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        'MyMoto',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                     'Einloggen...',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }


  void _UserStatus() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection("Users").document(firebaseUser.uid).get().then((value){
      _neworold.text = value.data['UserStatus'];
        if(value.data['UserStatus'] == 'New')
          Navigator.of(context).push(MaterialPageRoute(builder: (context){return NewUserName();}));
        else
          Navigator.of(context).push(MaterialPageRoute(builder: (context){return HomeScreen();}));
    });
  }

  }
