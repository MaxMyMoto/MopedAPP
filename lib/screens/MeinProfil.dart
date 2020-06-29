import 'package:MyMoto/models/Drawer.dart';
import 'package:MyMoto/models/NavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Startseite.dart';
import 'MeinProfilEdit.dart';


final databaseReference = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;




class MeinProfil extends StatefulWidget {
  @override
  _MeinProfilState createState() { return _MeinProfilState();}
}


class _MeinProfilState extends State<MeinProfil> {
  FirebaseUser user;
  String error;

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
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then(setUser).catchError(setError);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Color(0xff1e1e1e),
        centerTitle: true,
        title: Text("Mein Profil", style: TextStyle(
          fontFamily: 'texgyreadventors', color: Colors.white,),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white,), onPressed: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()),);
          }, iconSize: 25,)
        ],
      ),


      drawer: Drawer(child:
      Seitenleiste()
      ),


      bottomNavigationBar:
      NavBar(),

      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight*1.5),
        child:
          FloatingActionButton(
            onPressed: () {Navigator.push(
              context, MaterialPageRoute(builder: (context) => MeinProfilEdit()),);},
            child: IconButton(
                icon: Icon(
              Icons.edit,
              color: Colors.white,
            )),
            backgroundColor: Color(0xff272727),
          ),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,


      body: Container(
          color: Color(0xff333333),
          child: Column(children: <Widget>[
            SizedBox(
              height: (kToolbarHeight/2),
            ),
            user != null ? _buildTetting(context) : Text("Error: $error"),
            SizedBox(
              height: (kToolbarHeight/2),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
            child: user != null ? _buildSetting(context) : Text("Error: $error"),)


          ],)),
    );
  }


  Widget _buildTetting(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance.collection('Users')
            .document(user.uid)
            .collection('Profilbild')
            .document('URL')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          return new CircleAvatar(
            backgroundImage: NetworkImage(
              userDocument['Profilbild'].toString(),),
            radius: 60,
            backgroundColor: Colors.transparent,
          );
        });
  }



  Widget _buildSetting(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance.collection('Users')
            .document(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          return new Column(
            children: <Widget>[

          Row(
            children: <Widget>[
              Text("Name: " ,style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
              Text(userDocument['Name'].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
            ],
          ),

              Row(
                children: <Widget>[
                  Text("Alter: " ,style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                  Text(userDocument['Alter'].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                ],
              ),

              Row(
                children: <Widget>[
                  Text("Wohnort: " ,style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                  Text(userDocument['Land'].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                  Text("/" ,style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                  Text(userDocument['Stadt'].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                ],
              ),

              Row(
                children: <Widget>[
                  Text("Motorrad: " ,style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                  Text(userDocument['Motorrad'].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                ],
              ),

              Row(
                children: <Widget>[
                  Text("Gefahrene Strecke: " ,style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                  Text(userDocument['Gefahrene Strecke'].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                ],
              ),

              Row(
                children: <Widget>[
                  Text("Gefahrene Zeit: " ,style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                  Text(userDocument['Gefahrene Zeit'].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                ],
              ),

              Row(
                children: <Widget>[
                  Text("Mitglied seit: " ,style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                  Text(userDocument['Mitglied seit'].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Texgyreadventors', fontSize: 22),),
                ],
              ),



            ],
          );


        });
  }
}



Stream<DocumentSnapshot> provideDocumentFieldStream() {

  return Firestore.instance
      .collection('Users')
      .document()
      .snapshots();
}
//getUID() async {
 // final FirebaseUser user = await _auth.currentUser();
  //final uid = user.uid;
  //return  uid;
//}