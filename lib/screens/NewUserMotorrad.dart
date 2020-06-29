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


  }

  //Widget modelAuswahl(String string) {
  //  if(string == '/')
  //    YamahaCodePicker(    textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
  //       showOnlyYamahaWhenClosed: true,
  //       showYamahaOnly: true, //eg. 'GBP'
  //       );
  //  if(string =='Yamaha' )
  //    YamahaCodePicker(
  //       textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
  //       showOnlyYamahaWhenClosed: true,
  //        showYamahaOnly: true, //eg. 'GBP'
  //       );
  //  if(string =='Ducati')
  //    DucatiCodePicker(
  //       textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
  //        showOnlyDucatiWhenClosed: true,
  //        showDucatiOnly: true, //eg. 'GBP'
//        );
  // }



  void _updateMotorradMarkeData(String string) async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
        .updateData({

      'MotorradMarke': string,



    });

  }

  
  @override
  Widget build(BuildContext context) {
setState(() {

});
    return Scaffold(
      body:
      Container(
        color: Color(0xff272727),
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
                initialSelection: ('Sonstiges'),
                onChanged: (e) {
                  _updateMotorradMarkeData(e.toMarkenStringOnly());


                }
              ),
            ),
            SizedBox(
              height: (kToolbarHeight / 2),
            ),
            Center(
              child: SizedBox(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)),
                  color: Color(0xf272727),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewUserMotorradModell()),
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
              ),
            )
          ],
        )),
      )
      ,
    );
  }



}