import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Startseite.dart';

final databaseReference = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class NewUserMotorradBaujahr extends StatefulWidget {
  final String MotoMarke;
  final String MotoModell;
  // ignore: non_constant_identifier_names
  NewUserMotorradBaujahr(this.MotoMarke,this.MotoModell);

  @override
  _NewUserMotorradBaujahrState createState() => _NewUserMotorradBaujahrState();
}



class _NewUserMotorradBaujahrState extends State<NewUserMotorradBaujahr> {
  FirebaseUser user;
  String error;
  final MarkeController = TextEditingController();
  final ModellController = TextEditingController();

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

    // Clean up the controller when the widget is disposed.
    ModellController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then(setUser).catchError(setError);

  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconButton(
                padding: const EdgeInsets.all(0),
                iconSize: 20,
                icon: Icon(
                  Icons.close,
                ),
                onPressed: () => Navigator.pop(context),
              ),

            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height:
                  MediaQuery.of(context).size.height * 0.7,
                  child:
                  user != null ? _buildTetting(context) : Text(
              "Error: $error"),

                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _Button(String string){
    if(string == '/')
      return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/image/aj.png',width: 32,),
          SizedBox(width: 15,),
          Text('Auswählen', style: TextStyle(color: Colors.white,fontFamily: 'Texgyreadventors',fontSize: 22),),
        ],
      );
    if(string != '/')
      return new Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Text(string, style: TextStyle(color: Colors.white,fontFamily: 'Texgyreadventors',fontSize: 22),),
    ],
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
              _WeiterButton(userDocument['MotorradBaujahr']),
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
            _updateUserStatus();
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
              _Button(userDocument['MotorradBaujahr']),
              )
          );
        });
  }


  Widget _buildTetting(BuildContext context) {

        return new StreamBuilder(
            stream: Firestore.instance.collection('Motorräder')
                .document(widget.MotoMarke.toString())
                .collection('Modelle')
                .document(widget.MotoModell.toString())
                .snapshots(),
            builder: (context, snapshot2) {
              if (!snapshot2.hasData) {
                return new Text("Loading");
              }
              var userDocument = snapshot2.data;
              if (userDocument['N'] == 1.toString())
                return new ListView(children: <Widget>[
                  Container(height: 50,
                    color: Colors.transparent,
                    child: FlatButton(
                        onPressed: () => updateBaujahr(userDocument['Baujahr 1']),
                      child: Text(userDocument['Baujahr 1'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                ],);
              if (userDocument['N'] == 2.toString())
                return new ListView(children: <Widget>[
                  Container(height: 50,
                  color: Colors.transparent,
                  child: FlatButton(
                      onPressed: () => updateBaujahr(userDocument['Baujahr 1']),
                      child: Text(userDocument['Baujahr 1'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                  Container(height: 50,
                    color: Colors.transparent,
                    child: FlatButton(
                        onPressed: () => updateBaujahr(userDocument['Baujahr 2']),
                      child: Text(userDocument['Baujahr 2'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                ],);
              if (userDocument['N'] == 3.toString())
                return new ListView(children: <Widget>[
                  Container(height: 50,
                  color: Colors.transparent,
                  child: FlatButton(
                      onPressed: () => updateBaujahr(userDocument['Baujahr 1']),
                      child: Text(userDocument['Baujahr 1'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 2']),
                      child: Text(userDocument['Baujahr 2'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                  Container(height: 50,
                    color: Colors.transparent,
                    child: FlatButton(
                        onPressed: () => updateBaujahr(userDocument['Baujahr 3']),
                      child: Text(userDocument['Baujahr 3'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                ],);
              if (userDocument['N'] == 4.toString())
                return new ListView(children: <Widget>[
                  Container(height: 50,
                  color: Colors.transparent,
                  child: FlatButton(
                      onPressed: () => updateBaujahr(userDocument['Baujahr 1']),
                      child: Text(userDocument['Baujahr 1'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 2']),
                      child: Text(userDocument['Baujahr 2'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 3']),
                      child: Text(userDocument['Baujahr 3'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                  Container(height: 50,
                    color: Colors.transparent,
                    child: FlatButton(
                        onPressed: () => updateBaujahr(userDocument['Baujahr 4']),
                      child: Text(userDocument['Baujahr 4'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                ],);
              if (userDocument['N'] == 5.toString())
                return new ListView(children: <Widget>[
                  Container(height: 50,
                  color: Colors.transparent,
                  child: FlatButton(
                      onPressed: () => updateBaujahr(userDocument['Baujahr 1']),
                      child: Text(userDocument['Baujahr 1'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 2']),
                      child: Text(userDocument['Baujahr 2'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 3']),
                      child: Text(userDocument['Baujahr 3'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 4']),
                      child: Text(userDocument['Baujahr 4'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                  Container(height: 50,
                    color: Colors.transparent,
                    child: FlatButton(
                        onPressed: () => updateBaujahr(userDocument['Baujahr 5']),
                      child: Text(userDocument['Baujahr 5'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                ],);
              if (userDocument['N'] == 6.toString())
                return new ListView(children: <Widget>[
                  Container(height: 50,
                  color: Colors.transparent,
                  child: FlatButton(
                      onPressed: () => updateBaujahr(userDocument['Baujahr 1']),
                      child: Text(userDocument['Baujahr 1'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 2']),
                      child: Text(userDocument['Baujahr 2'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 3']),
                      child: Text(userDocument['Baujahr 3'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 4']),
                      child: Text(userDocument['Baujahr 4'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 5']),
                      child: Text(userDocument['Baujahr 5'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                  Container(height: 50,
                    color: Colors.transparent,
                    child: FlatButton(
                        onPressed: () => updateBaujahr(userDocument['Baujahr 6']),
                      child: Text(userDocument['Baujahr 6'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                ],);
              if (userDocument['N'] == 7.toString())
                return new ListView(children: <Widget>[
                  Container(height: 50,
                  color: Colors.transparent,
                  child: FlatButton(
                      onPressed: () => updateBaujahr(userDocument['Baujahr 1']),
                      child: Text(userDocument['Baujahr 1'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 2']),
                      child: Text(userDocument['Baujahr 2'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 3']),
                      child: Text(userDocument['Baujahr 3'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 4']),
                      child: Text(userDocument['Baujahr 4'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 5']),
                      child: Text(userDocument['Baujahr 5'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 6']),
                      child: Text(userDocument['Baujahr 6'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                  Container(height: 50,
                    color: Colors.transparent,
                    child: FlatButton(
                        onPressed: () => updateBaujahr(userDocument['Baujahr 7']),
                      child: Text(userDocument['Baujahr 7'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                ],);
              if (userDocument['N'] == 8.toString())
                return new ListView(children: <Widget>[
                  Container(height: 50,
                  color: Colors.transparent,
                  child: FlatButton(
                      onPressed: () => updateBaujahr(userDocument['Baujahr 1']),
                      child: Text(userDocument['Baujahr 1'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 2']),
                      child: Text(userDocument['Baujahr 2'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 3']),
                      child: Text(userDocument['Baujahr 3'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 4']),
                      child: Text(userDocument['Baujahr 4'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 5']),
                      child: Text(userDocument['Baujahr 5'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 6']),
                      child: Text(userDocument['Baujahr 6'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 7']),
                      child: Text(userDocument['Baujahr 7'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                  Container(height: 50,
                    color: Colors.transparent,
                    child: FlatButton(
                        onPressed: () => updateBaujahr(userDocument['Baujahr 8']),
                      child: Text(userDocument['Baujahr 8'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                ],);
              if (userDocument['N'] == 9.toString())
                return new ListView(children: <Widget>[
                  Container(height: 50,
                  color: Colors.transparent,
                  child: FlatButton(
                      onPressed: () => updateBaujahr(userDocument['Baujahr 1']),
                      child: Text(userDocument['Baujahr 1'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 2']),
                      child: Text(userDocument['Baujahr 2'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 3']),
                      child: Text(userDocument['Baujahr 3'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 4']),
                      child: Text(userDocument['Baujahr 4'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 5']),
                      child: Text(userDocument['Baujahr 5'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 6']),
                      child: Text(userDocument['Baujahr 6'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 7']),
                      child: Text(userDocument['Baujahr 7'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 8']),
                      child: Text(userDocument['Baujahr 8'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                  Container(height: 50,
                    color: Colors.transparent,
                    child: FlatButton(
                        onPressed: () => updateBaujahr(userDocument['Baujahr 9']),
                      child: Text(userDocument['Baujahr 9'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                ],);
              if (userDocument['N'] == 10.toString())
                return new ListView(children: <Widget>[
                  Container(height: 50,
                  color: Colors.transparent,
                  child: FlatButton(
                      onPressed: () => updateBaujahr(userDocument['Baujahr 1']),
                      child: Text(userDocument['Baujahr 1'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 2']),
                      child: Text(userDocument['Baujahr 2'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 3']),
                      child: Text(userDocument['Baujahr 3'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 4']),
                      child: Text(userDocument['Baujahr 4'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 5']),
                      child: Text(userDocument['Baujahr 5'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 6']),
                      child: Text(userDocument['Baujahr 6'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 7']),
                      child: Text(userDocument['Baujahr 7'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 8']),
                      child: Text(userDocument['Baujahr 8'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 9']),
                      child: Text(userDocument['Baujahr 9'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                  Container(height: 50,
                    color: Colors.transparent,
                    child: FlatButton(
                        onPressed: () => updateBaujahr(userDocument['Baujahr 10']),
                      child: Text(userDocument['Baujahr 10'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                ],);
              if (userDocument['N'] == 11.toString())
                return new ListView(children: <Widget>[
                  Container(height: 50,
                  color: Colors.transparent,
                  child: FlatButton(
                      onPressed: () => updateBaujahr(userDocument['Baujahr 1']),
                      child: Text(userDocument['Baujahr 1'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 2']),
                      child: Text(userDocument['Baujahr 2'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 3']),
                      child: Text(userDocument['Baujahr 3'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 4']),
                      child: Text(userDocument['Baujahr 4'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 5']),
                      child: Text(userDocument['Baujahr 5'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 6']),
                      child: Text(userDocument['Baujahr 6'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 7']),
                      child: Text(userDocument['Baujahr 7'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 8']),
                      child: Text(userDocument['Baujahr 8'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
              Container(height: 50,
              color: Colors.transparent,
              child: FlatButton(
                  onPressed: () => updateBaujahr(userDocument['Baujahr 9']),
                      child: Text(userDocument['Baujahr 9'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                  Container(height: 50,
                    color: Colors.transparent,
                    child: FlatButton(
                        onPressed: () => updateBaujahr(userDocument['Baujahr 10']),
                      child: Text(userDocument['Baujahr 10'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                  Container(height: 50,
                    color: Colors.transparent,
                    child: FlatButton(
                        onPressed: () => updateBaujahr(userDocument['Baujahr 11']),
                      child: Text(userDocument['Baujahr 11'].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Texgyreadventors'),)),),
                ],);
            });
      }
      
  void updateBaujahr(String string) async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
        .updateData({

      'MotorradBaujahr': string,
    }
    );
    Navigator.pop(context);

  }


  @override
  Widget build(BuildContext context) {

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
              Text("Wähle dein Baujahr"
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
           Padding(padding: EdgeInsets.only(left: 45, right: 45),child: Center(
             child: FlatButton(
               color: Color(0xff272727),
               onPressed:() {
                 _showMyDialog();
               } ,
              child: user != null ? _buildSetting(context) : Text(
                  "Error: $error"),),
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
      ,
    );
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
