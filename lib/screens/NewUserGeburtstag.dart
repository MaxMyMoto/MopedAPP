
import 'dart:ui';

import 'package:MyMoto/screens/NewUserWohnort.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marken_code_picker/marken_code_picker.dart';

final databaseReference = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;



class NewUserGeburtstag extends StatefulWidget {
  @override
  _NewUserGeburtstagState createState() => _NewUserGeburtstagState();
}

class _NewUserGeburtstagState extends State<NewUserGeburtstag> {
  FirebaseUser user;
  String error;
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();


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
    _date.dispose();
    super.dispose();
  }

  void _updateGeburtsdatum() async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;

    await databaseReference.collection("Users").document(uid).updateData({
      'Geburtsdatum': _date.text,
    });
  }

  void _updateAge(String string,String string2) async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
        .updateData({

      'Alter': string,
      'GeburtsdatumRechnen': string2,
    });
  }

  var myFormat = DateFormat('dd-MM-yyyy');


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date.value =
            TextEditingValue(text: ('${myFormat.format(picked).toString()}'));
        final Geburtstag = DateTime.parse(selectedDate.toString());
        final Jetzt = DateTime.now();

       final age = Jetzt.difference(Geburtstag).inDays;
       final age1 = age/365;
       final age2 = age1.toInt();
        _updateAge(age2.toString(),selectedDate.toString());
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff272727),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: (kToolbarHeight / 2),
              ),
              Center(
                child: Text(
                  "Wann hast du Geburtstag?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'texgyreadventors',
                      fontSize: 30,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 30),
                child: TextFormField(
                  controller: _date,
                  keyboardType: TextInputType.datetime,
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _selectDate(context);
                  },

                  style: TextStyle(
                      fontFamily: 'texgyreadventors',
                      fontSize: 22,
                      color: Colors.white),
                  decoration: InputDecoration(

                    suffix:user != null ? _buildSetting(context) : Text(
                        "Error: $error"),


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
                    hintText: "Geburtsdatum",
                    hintStyle: TextStyle(
                        fontFamily: 'texgyreadventors',
                        fontSize: 22,
                        color: Colors.white70),
                  ),
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
                      _updateGeburtsdatum();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewUserWohnort()),
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
          ),
        ),
      ),
    );
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
          return new  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                userDocument['Alter'],
                style: TextStyle(
                    fontFamily: 'texgyreadventors',
                    fontSize: 15,
                    color: Colors.white),
              ),
              Text(
                "Jahre alt",
                style: TextStyle(
                    fontFamily: 'texgyreadventors',
                    fontSize: 10,
                    color: Colors.white),
              ),
            ],
          );
        });
  }

}