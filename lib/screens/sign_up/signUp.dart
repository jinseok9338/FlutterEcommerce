import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_app/utils/addUserData.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
=======
>>>>>>> 79e11375c0b3104af62aba67e765b6ab8b96968d

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<User> registerWithEmailAndPassword(String email, String password) async {
  //Create User
  final UserCredential user = await _auth
      .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
      .catchError((onError) =>
          ({"error": "There has been an error with registration"}) as User);
  print("Sign Up Suceessful with");
  print(user);

  var userData = {
    "uuid": user.user.uid,
    "email": user.user.email,
    "displayname":
        user.user.displayName != null ? user.user.displayName : user.user.email,
    "photoURL": "",
  };

  await firestore
      .collection("Users")
      .doc(user.user.uid)
      .set(userData)
      .catchError((onError) =>
          ({"error": "There has been an error when adding the data"}) as User);

  print("user Data is");
  print(userData);

  //Navigate to Login page
  return userData as User;
}

//SignUpWithGoogle

Future<User> signInWithGoogle({BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
        print(e.code);
        return {"error": "There has been an error when Registering"} as User;
      } else if (e.code == 'invalid-credential') {
        // handle the error here
        print(e.code);
        return {"error": "There has been an error when Registering"} as User;
      }
    } catch (e) {
      // handle the error here
      print(e.code);
      return {"error": "There has been an error when Registering"} as User;
    }
  }

  user = addUserData(user) as User;

  return user;
}

//Signup With Twitter
Future<User> signInWithTwitter({BuildContext context}) async {
  final TwitterLogin twitterLogin = TwitterLogin(
    consumerKey: DotEnv().env['CONSUMERKEY'],
    consumerSecret: DotEnv().env['CONSUMERSECRET'],
  );

  final TwitterLoginResult result = await twitterLogin.authorize();
<<<<<<< HEAD
  //Todo Finailize the Log in Process
=======
>>>>>>> 79e11375c0b3104af62aba67e765b6ab8b96968d
}

//error show Dialog
// ignore: non_constant_identifier_names
void error_showDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Error"),
        content: new Text("Something went Wrong"),
        actions: <Widget>[
          new TextButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
