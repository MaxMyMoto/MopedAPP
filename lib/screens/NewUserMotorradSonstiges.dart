import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Startseite.dart';

final databaseReference = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class NewUserMotorradSonstiges extends StatefulWidget {
  final String MotoMarke;
  // ignore: non_constant_identifier_names
  NewUserMotorradSonstiges(this.MotoMarke,);

  @override
  _NewUserMotorradSonstigesState createState() => _NewUserMotorradSonstigesState();
}



class _NewUserMotorradSonstigesState extends State<NewUserMotorradSonstiges> {
  FirebaseUser user;
  String error;
  final MarkeController = TextEditingController();
  final ModellController = TextEditingController();
  final BaujahrC = TextEditingController();
  final PSC = TextEditingController();
  final HubraumC = TextEditingController();
  final ModellC = TextEditingController();
  final ClearC = TextEditingController();

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
    MarkeController.dispose();
    super.dispose();
    ClearC.dispose();
    super.dispose();

    // Clean up the controller when the widget is disposed.
    ModellController.dispose();
    super.dispose();

    BaujahrC.dispose();
    super.dispose();

    PSC.dispose();
    super.dispose();

    HubraumC.dispose();
    super.dispose();
    ModellC.dispose();
    super.dispose();

  }
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then(setUser).catchError(setError);
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      Container(height: MediaQuery.of(context).size.height,
        color: Color(0xff272727),
        child: SafeArea(child:SingleChildScrollView(child: Column(
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
              Text("Gebe die Technische Daten deines Motorrads an", textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'texgyreadventors',
                  fontSize: 20,
                  color: Colors.white70,
                ),),
              ),
            ),
            SizedBox(
              height: (kToolbarHeight / 2),
            ),Padding(
    padding: EdgeInsets.only(left: 30, right: 30),
    child: Center(child:
            TextFormField(
              controller: ModellC,
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
                hintText: "Modell",
                hintStyle: TextStyle(
                    fontFamily: 'texgyreadventors',
                    fontSize: 22,
                    color: Colors.white70),
              ),
            ),),),
            SizedBox(
              height: (kToolbarHeight / 2),
            ),
            Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
    child: Center(child:
            TextFormField(
              keyboardType: TextInputType.number,
              controller: BaujahrC,
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
                hintText: "Baujahr",
                hintStyle: TextStyle(
                    fontFamily: 'texgyreadventors',
                    fontSize: 22,
                    color: Colors.white70),
              ),
            ),
    ),),
            SizedBox(
              height: (kToolbarHeight / 2),
            ),
    Padding(
    padding: EdgeInsets.only(left: 30, right: 30),
    child: Center(child:
            TextFormField(
              keyboardType: TextInputType.number,
              controller: PSC,
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
                hintText: "PS",
                hintStyle: TextStyle(
                    fontFamily: 'texgyreadventors',
                    fontSize: 22,
                    color: Colors.white70),
              ),
            ),),),
            SizedBox(
              height: (kToolbarHeight / 2),
            ),
    Padding(
    padding: EdgeInsets.only(left: 30, right: 30),
    child: Center(child:
            TextFormField(
              keyboardType: TextInputType.number,
controller: HubraumC,
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
                hintText: "Hubraum",
                hintStyle: TextStyle(
                    fontFamily: 'texgyreadventors',
                    fontSize: 22,
                    color: Colors.white70),
              ),
            ),),
            ),
            SizedBox(
              height: (kToolbarHeight / 2),
            ),
            _WeiterButton(),
          ],
        )),
      )
      ,),
    );
  }


  Widget _WeiterButton(){
if(ModellC.text.toString() != ClearC.text.toString() && BaujahrC.text.toString() != ClearC.text.toString() && PSC.text.toString() != ClearC.text.toString() && HubraumC.text.toString() != ClearC.text.toString() )
  return SizedBox(
    child: RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.white)),
      color: Color(0xf272727),
      onPressed: () {
        _updateUserStatus();
        _updateMotorradSontiges();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
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
else
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
  }
  void _updateMotorradSontiges() async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
        .collection("NutzerDaten")
        .document("Motorrad")
        .updateData({

      'MotorradModell': ModellC.text.toString(),
      'MotorradBaujahr' : BaujahrC.text.toString(),
      'MotorradPS': PSC.text.toString(),
      'MotorradHubraum' : HubraumC.text.toString(),

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
