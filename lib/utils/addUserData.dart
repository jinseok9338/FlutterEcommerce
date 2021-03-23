import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/screens/sign_up/SignUpUserType.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<Map<String, String>> addUserData(User user) async {
  var storedUserRef = firestore.collection("Users").doc(user.uid);

  storedUserRef.get().then((res) async {
    if (res.data() == null) {
      print("user is not registered yet");
      var userData = {
        "uuid": user.uid,
        "email": user.email,
        "displayname": user.displayName != null ? user.displayName : user.email,
        "photoURL": user.photoURL,
        "createdAt": DateTime.now()
      };

      await firestore
          .collection("Users")
          .doc(user.uid)
          .set(userData)
          .catchError((onError) => ({
                "error": "There has been an error when adding the data"
              }) as Map<String, String>);
      print("user Data is");
      print(userData);

      return userData as SignupUser;
    } else {
      print("user is already registered");
      print(res.data());
      return res.data();
    }
  }).catchError((onError) =>
      {"error": "there has been some error"} as Map<String, String>);
}
