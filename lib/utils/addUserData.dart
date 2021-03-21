import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<User> addUserData(User user) async {
  var storedUserRef = firestore.collection("Users").doc(user.uid);

  storedUserRef.get().then((res) async {
    if (res.data() == null) {
      var userData = {
        "uuid": user.uid,
        "email": user.email,
        "displayname": user.displayName != null ? user.displayName : user.email,
        "photoURL": user.photoURL,
      };

      await firestore
          .collection("Users")
          .doc(user.uid)
          .set(userData)
          .catchError((onError) => ({
                "error": "There has been an error when adding the data"
              }) as User);
      print("user Data is");
      print(userData);

      return userData as User;
    }

    return user;
  }).catchError((onError) => {"error": "there has been some error"} as User);
}
