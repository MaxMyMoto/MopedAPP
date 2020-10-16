import 'package:MyMoto/screens/NewUserMotorradBaujahr.dart';
import 'package:MyMoto/screens/Startseite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marken_code_picker/marken_code_picker.dart';
import 'package:ducati_code_picker/ducati_code_picker.dart';
import 'package:yamaha_code_picker/yamaha_code_picker.dart';
import 'package:honda_code_picker/honda_code_picker.dart';
import 'package:suzuki_code_picker/suzuki_code_picker.dart';
import 'package:kawasaki_code_picker/kawasaki_code_picker.dart';
import 'package:bmw_code_picker/bmw_code_picker.dart';
import 'package:ktm_code_picker/ktm_code_picker.dart';
import 'package:harleydavidson_code_picker/harleydavidson_code_picker.dart';
import 'package:triumph_code_picker/triumph_code_picker.dart';
import 'package:aprilia_code_picker/aprilia_code_picker.dart';
import 'package:husqvarna_code_picker/husqvarna_code_picker.dart';
import 'package:mva_code_picker/mva_code_picker.dart';

final databaseReference = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;


class NewUserMotorradModell extends StatefulWidget {
  final String MotorradMarke;
  // ignore: non_constant_identifier_names
  NewUserMotorradModell(this.MotorradMarke);

  @override
  _NewUserMotorradModellState createState() => _NewUserMotorradModellState();
}

class _NewUserMotorradModellState extends State<NewUserMotorradModell> {
  final MarkeController = TextEditingController();
  final ModellController = TextEditingController();
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

    ModellController.dispose();
    super.dispose();


  }




  void _updateModellData(String string) async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
        .updateData({

      'MotorradModell': string,
    }
    );
    ModellController.text = string;
  }

Widget _ModellAuswahl(String string){
    MarkeController.text = string;
    if (string == 'Yamaha')
      return new YamahaCodePicker(
        initialSelection: ('Auswählen'),
        textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
        showOnlyYamahaWhenClosed: true,
        showLogo: true,
        showYamahaOnly: true, //eg. 'GBP'
          onChanged: (e) {
            _updateModellData(e.toYamahaStringOnly());}
      );
    if (string == 'Ducati')
      return new DucatiCodePicker(
          initialSelection: ('Auswählen'),
        textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
        showOnlyDucatiWhenClosed: true,
        showLogo: true,
        showDucatiOnly: true, //eg. 'GBP'
  onChanged: (e) {
  _updateModellData(e.toDucatiStringOnly());}
      );
    if (string == 'Honda')
      return new HondaCodePicker(
          initialSelection: ('Auswählen'),
        textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
        showOnlyHondaWhenClosed: true,
        showLogo: true,
        showHondaOnly: true, //eg. 'GBP'
   onChanged: (e) {
  _updateModellData(e.toHondaStringOnly());}

      );
    if (string == 'Suzuki')
      return new SuzukiCodePicker(
          initialSelection: ('Auswählen'),
        textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
        showOnlySuzukiWhenClosed: true,
        showLogo: true,
        showSuzukiOnly: true, //eg. 'GBP'
  onChanged: (e) {
  _updateModellData(e.toSuzukiStringOnly());}
      );
    if (string == 'Kawasaki')
      return new KawasakiCodePicker(
          initialSelection: ('Auswählen'),
        textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
        showOnlyKawasakiWhenClosed: true,
        showLogo: true,
        showKawasakiOnly: true, //eg. 'GBP'
  onChanged: (e) {
  _updateModellData(e.toKawasakiStringOnly());}
      );
    if (string == 'BMW')
      return new BmwCodePicker(
          initialSelection: ('Auswählen'),
        textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
        showOnlyBmwWhenClosed: true,
        showLogo: true,
        showBmwOnly: true, //eg. 'GBP'
  onChanged: (e) {
  _updateModellData(e.toBmwStringOnly());}
      );
    if (string == 'KTM')
      return new KtmCodePicker(
          initialSelection: ('Auswählen'),
        textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
        showOnlyKtmWhenClosed: true,
        showLogo: true,
        showKtmOnly: true, //eg. 'GBP'
  onChanged: (e) {
  _updateModellData(e.toKtmStringOnly());}
      );
    if (string == 'Harley Davidson')
      return new HarleydavidsonCodePicker(
          initialSelection: ('Auswählen'),
        textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
        showOnlyHarleydavidsonWhenClosed: true,
        showLogo: true,
        showHarleydavidsonOnly: true, //eg. 'GBP'
  onChanged: (e) {
  _updateModellData(e.toHarleydavidsonStringOnly());}
      );
    if (string == 'Triumph')
      return new TriumphCodePicker(
          initialSelection: ('Auswählen'),
        textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
        showOnlyTriumphWhenClosed: true,
        showLogo: true,
        showTriumphOnly: true, //eg. 'GBP'
  onChanged: (e) {
  _updateModellData(e.toTriumphStringOnly());}
      );
    if (string == 'Aprilia')
      return new ApriliaCodePicker(
          initialSelection: ('Auswählen'),
        textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
        showOnlyApriliaWhenClosed: true,
        showLogo: true,
        showApriliaOnly: true, //eg. 'GBP'
  onChanged: (e) {
  _updateModellData(e.toApriliaStringOnly());}
      );
    if (string == 'Husqvarna')
      return new HusqvarnaCodePicker(
          initialSelection: ('Auswählen'),
        textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
        showOnlyHusqvarnaWhenClosed: true,
        showLogo: true,
        showHusqvarnaOnly: true, //eg. 'GBP'
  onChanged: (e) {
  _updateModellData(e.toHusqvarnaStringOnly());}
      );
    if (string == 'MV Agusta')
      return new MvaCodePicker(
          initialSelection: ('Auswählen'),
        textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
        showOnlyMvaWhenClosed: true,
        showLogo: true,
        showMvaOnly: true, //eg. 'GBP'
  onChanged: (e) {
  _updateModellData(e.toMvaStringOnly());}
      );

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
              Text("Wähle dein Modell"
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
            user != null ? _buildSetting(context) : Text(
                "Error: $error"),
            SizedBox(
              height: (kToolbarHeight / 2),
            ),
            user != null ? _buildKetting(context) : Text(
                "Error: $error"),
          ],
        )),
      )
      ,
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
              _WeiterButton(userDocument['MotorradModell']),
              )
          );
        });
  }

  Widget _WeiterButton(String string) {
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
              MaterialPageRoute(builder: (context) => NewUserMotorradBaujahr(widget.MotorradMarke, ModellController.text)),
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
          return new Padding(padding:EdgeInsets.only(left: 30, right: 30),
              child:
            Center(child:
              _ModellAuswahl(userDocument['MotorradMarke']),
            )
          );
        });
  }

  void _updateUserStatus() async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
        .updateData({

      'UserStatus': "old",



    });
  }

}