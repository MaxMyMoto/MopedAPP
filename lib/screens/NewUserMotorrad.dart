import 'package:MyMoto/screens/NewUserMotorradSonstiges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marken_code_picker/marken_code_picker.dart';
import 'package:ducati_code_picker/ducati_code_picker.dart';
import 'package:yamaha_code_picker/yamaha_code_picker.dart';

import 'NewUserMotorradModell.dart';


final databaseReference = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;


class NewUserMotorrad extends StatefulWidget {
  @override
  _NewUserMotorradState createState() => _NewUserMotorradState();
}

class _NewUserMotorradState extends State<NewUserMotorrad> {
  final MarkeController = TextEditingController();
  final MarkenController = TextEditingController();
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
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then(setUser).catchError(setError);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    MarkeController.dispose();
    super.dispose();

    MarkenController.dispose();
    super.dispose();


  }


  void _updateMotorradMarkeData(String string) async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
        .updateData({

      'MotorradMarke': string,



    });

  }
  void _updateMotorradSontiges(String string) async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
    .collection("NutzerDaten")
    .document("Motorrad")
        .setData({

      'MotorradMarke': string,



    });
    await databaseReference.collection("Users")
        .document(uid)
        .updateData({

      'MotorradModell': "/",
      'MotorradBaujahr' : "/",



    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        color: Color(0xff272727), height: MediaQuery.of(context).size.height,
    child:
    SingleChildScrollView(

        child: SafeArea(child: Column(
          children: <Widget>[
            SizedBox(height: kToolbarHeight/2,),
            Padding(
              padding: EdgeInsets.only(left: kToolbarHeight, right: kToolbarHeight),
              child: Center(child:
            Text(
              "Welches Motorrad fährst du?",
              style: TextStyle(
                  fontFamily: 'texgyreadventors',
                  fontSize: 30,
                  color: Colors.white),
            ),
            ),
            ),
            SizedBox(
              height: (kToolbarHeight / 2),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Center(child:
                Text("Wähle deine Marke"
                ,style: TextStyle(
                    fontFamily: 'texgyreadventors',
                    fontSize: 20,
                    color: Colors.white70,
                  ),),
              ),
            ),
            SizedBox(
              height: (kToolbarHeight / 2),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30,),
              child: MarkenCodePicker(
                textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
                showOnlyMarkenWhenClosed: true,
                showMarkenOnly: true, //eg. 'GBP'
                initialSelection: ('Auswählen'),
                onChanged: (e) {
                  _updateMotorradMarkeData(e.toMarkenStringOnly());
                  MarkeController.text = e.toMarkenStringOnly();


                }
              ),
            ),
            SizedBox(
              height: (kToolbarHeight / 2),
            ),
            user != null ? _buildKetting(context) : Text(
                "Error: $error"),
          ],
        )),
      )
      ,)
    );
  }

  Widget _buildKetting(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance.collection('Users')
            .document(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          return new Padding(padding:EdgeInsets.only(left: 30, right: 30),
              child:
              Center(child:
              _WeiterButton(userDocument['MotorradMarke']),
              )
          );
        });
  }

  Widget _WeiterButton(String string) {
    if(string == "Sonstiges")
      return Column(children: <Widget>[
        Text("Gebe deine Motorrad-Marke ein",style: TextStyle(fontFamily: 'Texgyreadventors',fontSize: 20, color: Colors.white70),),
        SizedBox(
          height: (kToolbarHeight / 2),
        ),
        TextFormField(
          controller: MarkenController,
          style: TextStyle(
              fontFamily: 'texgyreadventors',
              fontSize: 22,
              color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Marke",
            hintStyle: TextStyle(
                fontFamily: 'texgyreadventors',
                fontSize: 22,
                color: Colors.white70),
          ),
        ),
        SizedBox(
          height: (kToolbarHeight / 2),
        ),
        SizedBox(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.white)),
        color: Color(0xf272727),
        onPressed: () {_onPressed();
        },
        child: Text(
          "Weiter",
          style: TextStyle(
              fontFamily: 'texgyreadventors',
              fontSize: 28,
              color: Colors.white),
        ),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      ),
    ),
      ],);
    if(string == "/" || string == "Auswählen")
      return SizedBox(
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white)),
          color: Color(0xf272727),
          onPressed: () {
          },
          child: Text(
            "Weiter",
            style: TextStyle(
                fontFamily: 'texgyreadventors',
                fontSize: 28,
                color: Colors.white),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        ),
      );
    else
      return SizedBox(
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white)),
          color: Color(0xf272727),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewUserMotorradModell(MarkeController.text)),
            );

          },
          child: Text(
            "Weiter",
            style: TextStyle(
                fontFamily: 'texgyreadventors',
                fontSize: 28,
                color: Colors.white),
          ),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        ),
      );
  }
void _onPressed() {
if(MarkenController.text != "")
  _updateMotorradSontiges(MarkenController.text);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NewUserMotorradSonstiges(MarkenController.text)),
  );


}

}