import 'package:cloud_firestore/cloud_firestore.dart';

class SignupUser {
  String displayName;
  String email;
  String photoURL;
  // List<Interest> interests;
  Timestamp createdAt;

  SignupUser({
    this.displayName,
    this.email,
    this.photoURL,
    //List<Interest> interests,
  }) {
    //this.interests = interests ?? [];
  }

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'email': email,
        'photoURL': photoURL,
        // 'interests': interests.toString(),
        // 'ethicsAgreement': ethicsAgreement,
      };
}
