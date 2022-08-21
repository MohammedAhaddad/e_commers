import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/moodels/Catgory.dart';
import 'package:e_commers/moodels/Prodact.dart';
import 'package:flutter/foundation.dart';

class FirestorHelper {
  FirestorHelper._();
  static FirestorHelper firestorHelper = FirestorHelper._();
  FirebaseFirestore firebaseInstanc = FirebaseFirestore.instance;

  Future<Catgory> addNewCatogry(Catgory catgory) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await firebaseInstanc.collection("categories").add(catgory.toMap());
    catgory.catId = documentReference.id;
    return catgory;
  }

  Future<List<Catgory>> getAllCaregories() async {
    QuerySnapshot<Map<String, dynamic>> querySnapsh =
        await firebaseInstanc.collection("categories").get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        querySnapsh.docs;
    List<Catgory> catrgories = documents.map((e) {
      Catgory catgory = Catgory.fromMap(e.data());
      catgory.catId = e.id;
      return catgory;
    }).toList();
    return catrgories;
  }

  deleteCatgory(Catgory catgory) async {
    await firebaseInstanc.collection("categories").doc(catgory.catId).delete();
  }

  updateCatgory(Catgory catgory) async {
    await firebaseInstanc
        .collection("categories")
        .doc(catgory.catId)
        .update(catgory.toMap());
  }

  Future<Prodact> addNewProduct(Prodact prodact, String catId) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await firebaseInstanc
            .collection("categories")
            .doc(catId)
            .collection("products")
            .add(prodact.toMap());
    prodact.id = documentReference.id;
    return prodact;
  }

  Future<List<Prodact>> getAllProduct(String catId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseInstanc
        .collection("categories")
        .doc(catId)
        .collection("products")
        .get();

    List<Prodact> prodacts = querySnapshot.docs.map((e) {
      Map<String, dynamic> data = e.data();
      data['id'] = e.id;
      Prodact prodt = Prodact.fromMap(data);
      // prodt.id = e.id;
      return prodt;
    }).toList();
    return prodacts;
  }

  updateProduct(Prodact prodact, String catId) async {
    await firebaseInstanc
        .collection("categories")
        .doc(catId)
        .collection("products")
        .doc(prodact.id)
        .update(prodact.toMap());
  }

  deleteProduct(Prodact prodact, String catId) async {
    await firebaseInstanc
        .collection("categories")
        .doc(catId)
        .collection("products")
        .doc(prodact.id)
        .delete();
  }
}
