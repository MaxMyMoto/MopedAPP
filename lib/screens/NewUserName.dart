import 'package:MyMoto/screens/NewUserGeburtstag.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


final databaseReference = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;


class NewUserName extends StatefulWidget {
  @override
  _NewUserNameState createState() => _NewUserNameState();
}


class _NewUserNameState extends State<NewUserName> {
  FirebaseUser user;
  String error;
  final VornameController = TextEditingController();
  final NachnameController = TextEditingController();

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
    VornameController.dispose();
    super.dispose();


    NachnameController.dispose();
    super.dispose();

  }

  void _updateVorUndNachNameData() async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
        .updateData({

      'Name': VornameController.text + " " + NachnameController.text,



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
                "Wie heißt du?",
                style: TextStyle(
                    fontFamily: 'texgyreadventors',
                    fontSize: 30,
                    color: Colors.white),
              ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 30),
                child: TextFormField(
                  controller: VornameController,
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
                    hintText: "Vorname",
                    hintStyle: TextStyle(
                        fontFamily: 'texgyreadventors',
                        fontSize: 22,
                        color: Colors.white70),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 30),
                child: TextFormField(
                  controller: NachnameController,
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
                    hintText: "Nachname",
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
                    _updateVorUndNachNameData();
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewUserGeburtstag()),);
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
}
