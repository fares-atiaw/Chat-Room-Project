import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/M_User.dart';

class Database_Utilities {
  static final MyUser =
      FirebaseFirestore.instance.collection('M_User').withConverter<M_User>(
            fromFirestore: (snapshot, _) => M_User.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  // static Future<void> create_userData(String authID, M_User userData) {
  //   return MyUser.doc(authID).set(userData)
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }
  static Future<M_User?> create_userData(M_User userData) {
    MyUser.doc(userData.id)
        .set(userData)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    return get_userData(userData.id ??
        ""); // If I have a free time, I will check for a better solution if exist.
  }

  static Future<M_User?> get_userData(String authID) async {
    return await MyUser.doc(authID)
        .get()
        .then((value) => value.data())
        .catchError((error) => print("Failed to login: $error"));
  }
}