import 'dart:io';
import 'package:MyMoto/models/sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MeinProfil.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';


final databaseReference = Firestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseStorage _storage = FirebaseStorage.instance;




class MeinProfilEdit extends StatefulWidget {
  @override
  _MeinProfilEditState createState() { return _MeinProfilEditState();}
}


class _MeinProfilEditState extends State<MeinProfilEdit> {
  FirebaseUser user;
  String error;
  File _image;
  String _uploadedFileURL;
  final NameController = TextEditingController();
  final LandController = TextEditingController();
  final StadtController = TextEditingController();
  Country _selected;




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
    NameController.dispose();
    super.dispose();


    LandController.dispose();
    super.dispose();

    // Clean up the controller when the widget is disposed.
    StadtController.dispose();
    super.dispose();
}


  Future _getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('_image: $_image');
      uploadFile(user.uid);
    });

  }



  Future uploadFile(String filename) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Users/$filename');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() async {
        _uploadedFileURL = fileURL;
        final FirebaseUser user = await _auth.currentUser();
        final uid = user.uid;


        await databaseReference.collection("Users")
            .document(uid)
            .collection("Profilbild")
            .document("URL")
            .setData({
          'Profilbild': _uploadedFileURL,


        });
      });
    });
  }
  void _updateNameData() async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;


    await databaseReference.collection("Users")
        .document(uid)
        .updateData({

      'Name': NameController.text ,



    });
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
      appBar:
      AppBar(
        backgroundColor: Color(0xff1e1e1e),
        centerTitle: true,
        title: Text("Profil bearbeiten", style: TextStyle(
          fontFamily: 'texgyreadventors', color: Colors.white,),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check, color: Colors.white,), onPressed: () {_updateNameData();_updateStadtData();
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => MeinProfil()),);
          }, iconSize: 25,)
        ],
      ),



      body: Container( height: MediaQuery.of(context).size.height,color: Color(0xff333333),
        child:
        SingleChildScrollView(

            child: Column(children: <Widget>[
              SizedBox(
                height: (kToolbarHeight/2),
              ),
              user != null ? _buildTetting(context) : Text("Error: $error"),
              SizedBox(
                height: (kToolbarHeight/2),
              ),
              Padding (
                padding: EdgeInsets.all(15),

                child:Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      color: Color(0xff272727),
                      onPressed: () {
                        _getImage();
                      },
                      child: Text(
                        'Neues Profilbild',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                    RaisedButton(
                      color: Color(0xff272727),
                      onPressed: () {
                        FirstUserPB();
                      },
                      child: Text(
                        'Profilbild entfernen',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                  ],
                ),),),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: user != null ? _buildSetting(context) : Text("Error: $error"),)


            ],)),
      ),
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

              Padding(
                padding: EdgeInsets.only(left:8, right: 8),
                child: TextFormField(

controller: NameController..text = userDocument['Name'],
                  onChanged: (text) => {},
                  style:TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
                  cursorColor: Colors.white,

                  decoration:
                  InputDecoration(

                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff1e1e1e)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff1e1e1e)),
                    ),
                    fillColor: Color(0xff1e1e1e),
                    labelText: 'Name',
                    labelStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white30),
                    border:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(
                          color: Color(0xff1e1e1e),
                        )
                    ),
                  ),
                ),),
              SizedBox(
                height: (kToolbarHeight/3),
              ),

              Padding(
                padding: EdgeInsets.all(8),
                child: CountryCodePicker(
textStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
                  initialSelection: userDocument['Land'],
                  showOnlyCountryWhenClosed: true,
favorite: ['Deutschland'],
                  showCountryOnly: true, //eg. 'GBP'
                  onChanged: (e) => _updateLandData(e.toCountryStringOnly()),

                ),),

              SizedBox(
                height: (kToolbarHeight/3),
              ),

              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  controller: StadtController..text = userDocument['Stadt'],
                  onChanged: (text) => {},

                  style:TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white),
                  cursorColor: Colors.white,

                  decoration:
                  InputDecoration(

                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff1e1e1e)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff1e1e1e)),
                    ),
                    fillColor: Color(0xff1e1e1e),
                    labelText: 'Stadt',
                    labelStyle: TextStyle(fontFamily: 'texgyreadventors', fontSize: 22, color: Colors.white30),
                    border:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(
                          color: Color(0xff1e1e1e),
                        )
                    ),
                  ),
                ),),


            ],
          );


        });
  }
}

