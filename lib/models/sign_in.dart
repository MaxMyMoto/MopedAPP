
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:intl/intl.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final databaseReference = Firestore.instance;





String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  if(authResult.additionalUserInfo.isNewUser){
    FirstUserData();FirstUserPB();

  }


  final FirebaseUser user = authResult.user;


  // Checking if email and name is null
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;

  // Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null,
  );

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}

void FirstUserData() async {

  final FirebaseUser user = await _auth.currentUser();
  final uid = user.uid;
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);

  await databaseReference.collection("Users")
      .document(uid)
      .setData({
    'Geburtsdatum': 'TT/MM/JJJJ',
    'GeburtsdatumRechnen': 'JJJJ/MM/TT 00:00:00.000',
    'Name': '/',
    'Alter': '/',
    'Land': '/',
    'Stadt': '/',
    'MotorradMarke': '/',
    'MotorradModell': '/',
    'MotorradBaujahr': '/',
    'Gefahrene Strecke': '0Km',
    'Gefahrene Zeit': '0h',
    'Mitglied seit' : formattedDate,
    'UserStatus' : 'New',
  });
}

void FirstUserPB() async {

  final FirebaseUser user = await _auth.currentUser();
  final uid = user.uid;

  await databaseReference.collection("Users")
  .document(uid)
  .collection("Profilbild")
  .document("URL")
  .setData({
    'Profilbild': 'https://firebasestorage.googleapis.com/v0/b/mymoto-2a4f4.appspot.com/o/Users%2FPBPlatzhalterpng.png?alt=media&token=f9e88136-b3e6-468a-957a-9ad910d02e42'
  });
}

