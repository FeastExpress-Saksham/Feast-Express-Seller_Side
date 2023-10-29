import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/user.dart';

class HomeServices {
  Future<List<LocalUser>> getLocalUsers() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<LocalUser> localUsers = [];
    db.collection("users").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          localUsers.add(LocalUser.fromMap(docSnapshot.data()));
        }
      },
    );
    return localUsers;
  }
}
