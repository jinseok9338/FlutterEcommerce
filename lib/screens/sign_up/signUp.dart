import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_app/utils/addUserData.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

import 'SignUpUserType.dart';
import 'package:dotenv/dotenv.dart' show load, env;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<SignupUser> registerWithEmailAndPassword(
    String email, String password) async {
  //Create User
  final UserCredential user = await _auth
      .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
      .catchError((onError) => ({
            "error": "There has been an error with registration"
          }) as SignupUser);
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
  return userData as SignupUser;
}

//SignUpWithGoogle

Future<Map<String, dynamic>> signInWithGoogle({BuildContext context}) async {
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
        return {"error": "There has been an error when Registering"};
      } else if (e.code == 'invalid-credential') {
        // handle the error here
        print(e.code);
        return {"error": "There has been an error when Registering"};
      }
    } catch (e) {
      // handle the error here
      print(e.code);
      return {"error": "There has been an error when Registering"};
    }
  }

  Map<String, dynamic> signedUpUser = await addUserData(user);
  print(signedUpUser);

  return signedUpUser;
}

//Signup With Twitter
Future<Map<String, dynamic>> signInWithTwitter({BuildContext context}) async {
  load();
  final TwitterLogin twitterLogin = TwitterLogin(
    consumerKey: "fTkIVLiSBLqER0BaGyAh4rajr",
    consumerSecret: "rnD61diKMw2d4eUlpbAAZPRyT7f1NJGtwwoXwZ9MoDZpD2Jmz0",
  );

  // Trigger the sign-in flow
  final TwitterLoginResult loginResult = await twitterLogin.authorize();

  // Get the Logged In session
  final TwitterSession twitterSession = loginResult.session;

  // Create a credential from the access token
  final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: twitterSession.token, secret: twitterSession.secret);

  // Once signed in, return the UserCredential
  final firebaseCredential =
      await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);

  Map<String, dynamic> user = await addUserData(firebaseCredential.user);

  return user;
}

//FaceBook Login
Future<Map<String, dynamic>> signInWithFacebook() async {
  try {
    // Trigger the sign-in flow
    final AccessToken accessToken = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential credential = FacebookAuthProvider.credential(
      accessToken.token,
    );

    // Once signed in, return the UserCredential
    final firebaseCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    Map<String, dynamic> user = await addUserData(firebaseCredential.user);
    return user;
  } on FacebookAuthException catch (e) {
    // handle the FacebookAuthException
    print(e.message);
    return {"error": "There has been an error when Registering"};
  } on FirebaseAuthException catch (e) {
    // handle the FirebaseAuthException
    print(e.code);
    return {"error": "There has been an error when Registering"};
  } finally {}
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
