import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/moodels/AppUser.dart';

class FirestorHelperUser {
  FirestorHelperUser._();
  static FirestorHelperUser firestorHelperUser = FirestorHelperUser._();

  CollectionReference<Map<String, dynamic>> userColection =
      FirebaseFirestore.instance.collection("users");

  insertDummyDataInFirstor() async {
    await userColection.add({});
  }

  addUserToFirestore(AppUser appUser) {
    userColection.doc(appUser.id).set(appUser.toMap());
  }

  getUserFromFirstor(String id) async {
    DocumentSnapshot<Map<String, dynamic>> user =
        await userColection.doc(id).get();
    return AppUser.fromMap(user.data()!);
  }

  deletCatogory() {}
  updateCatogory() {}
  addNewCatogory() {}
}
