import 'package:MyMoto/screens/NewUserGeburtstag.dart';
import 'package:MyMoto/screens/NewUserMotorrad.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


final databaseReference = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;


class NewUserWohnort extends StatefulWidget {
  @override
  _NewUserWohnortState createState() => _NewUserWohnortState();
}


class _NewUserWohnortState extends State<NewUserWohnort> {
  FirebaseUser user;
  String error;
  final LandController = TextEditingController();
  final StadtController = TextEditingController();


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
    LandController.dispose();
    super.dispose();

    // Clean up the controller when the widget is disposed.
    StadtController.dispose();
    super.dispose();

  }

  void _updateLandData(String string) async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
        .updateData({

      'Land': string ,



    });
  }

  void _updateStadtData() async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
        .updateData({

      'Stadt': StadtController.text ,



    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff272727),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: (kToolbarHeight/2),
              ),
              Center(child:
              Text(
                "Woher kommst du?",
                style: TextStyle(
                    fontFamily: 'texgyreadventors',
                    fontSize: 30,
                    color: Colors.white),
              ),
              ),
              SizedBox(
                height: (kToolbarHeight/2),
              ),
                   user != null ? _buildSetting(context) : Text("Error: $error"),

              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 30),
                child: TextFormField(
                  controller: StadtController,
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
                    hintText: "Stadt",
                    hintStyle: TextStyle(
                        fontFamily: 'texgyreadventors',
                        fontSize: 22,
                        color: Colors.white70),
                  ),
                ),
              ),
              SizedBox(
                height: (kToolbarHeight/2),
              ),

              Center(child: SizedBox(

                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)
                      ,side: BorderSide(color: Colors.white)
                  ),
                  color: Color(0xf272727),
                  onPressed: () {
                    _updateStadtData();
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => NewUserMotorrad()),);
                  },
                  child: Text("Weiter",style: TextStyle(fontFamily: 'texgyreadventors',fontSize: 28,color: Colors.white),),
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
          .collection('Profilbild')
          .document('URL')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        return new Padding(
          padding: EdgeInsets.all(8),
          child: CountryCodePicker(
            textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
            initialSelection: 'Auswählen',
            showOnlyCountryWhenClosed: true,
            favorite: ['Deutschland'],
            showCountryOnly: true, //eg. 'GBP'
            onChanged: (e) => _updateLandData(e.toCountryStringOnly()),

          ),);
      });
}}