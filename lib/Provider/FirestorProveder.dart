import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers/Data/FirestorHelper.dart';
import 'package:e_commers/Data/storageHelper.dart';
import 'package:e_commers/moodels/Catgory.dart';
import 'package:e_commers/moodels/ImagModel.dart';
import 'package:e_commers/moodels/Prodact.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class FirestorProveder extends ChangeNotifier {
  FirestorProveder() {
    getAllCategory();
    getAllProducts;
  }
  TextEditingController categoryNameConteoller = TextEditingController();

  TextEditingController productNameConteoller = TextEditingController();
  TextEditingController productDescConteoller = TextEditingController();
  TextEditingController productPriceConteoller = TextEditingController();
  TextEditingController productQuantityConteoller = TextEditingController();

  File? selectedImage;
  List<Catgory> catogeries = [];
  List<Prodact> listproducts = [];
  List<ImagModel> photos = [];

  selectIimg() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(xFile!.path);
    notifyListeners();
  }

  addNewCategory() async {
    if (selectedImage != null) {
      String ImageUrl =
          await StorageHelper.storageHelper.uploadImag(selectedImage!);
      Catgory catgory =
          Catgory(name: categoryNameConteoller.text, ImageUrl: ImageUrl);
      Catgory newCatgory =
          await FirestorHelper.firestorHelper.addNewCatogry(catgory);
      catogeries.add(newCatgory);
      resetCategory();
      notifyListeners();
    }
  }

  getAllCategory() async {
    catogeries = await FirestorHelper.firestorHelper.getAllCaregories();
    notifyListeners();
  }

  updateCategory(Catgory catgory) async {
    String? ImageUrl;
    if (selectedImage != null) {
      ImageUrl = await StorageHelper.storageHelper.uploadImag(selectedImage!);
    }
    Catgory newCatgory = Catgory(
        name: categoryNameConteoller.text,
        ImageUrl: ImageUrl ?? catgory.ImageUrl);
    newCatgory.catId = catgory.catId;
    await FirestorHelper.firestorHelper.updateCatgory(newCatgory);

    int index = catogeries.indexOf(
        catogeries.where((element) => element.catId == catgory.catId).first);

    catogeries[index] = newCatgory;
    resetCategory();
    notifyListeners();
  }

  deleteCategory(Catgory catgory) async {
    await FirestorHelper.firestorHelper.deleteCatgory(catgory);
    catogeries.removeWhere((element) => element.catId == catgory.catId);
    notifyListeners();
  }

  resetCategory() {
    selectedImage = null;
    categoryNameConteoller.clear();
  }

  getAllProducts(String catId) async {
    listproducts = await FirestorHelper.firestorHelper.getAllProduct(catId);

    notifyListeners();
  }

  addNewProduct(String catId) async {
    if (selectedImage != null) {
      String ImageUrl =
          await StorageHelper.storageHelper.uploadImag(selectedImage!);
      Prodact prodact = Prodact(
          description: productDescConteoller.text,
          name: productNameConteoller.text,
          price: num.parse(productPriceConteoller.text),
          quantity: int.parse(productQuantityConteoller.text),
          imag: ImageUrl);
      Prodact newProdact =
          await FirestorHelper.firestorHelper.addNewProduct(prodact, catId);
      listproducts.add(newProdact);
      ImagModel imagModel = ImagModel(url: ImageUrl);
      photos.add(imagModel);
      resetProdact();
      notifyListeners();
    }
  }

  updateProduct(Prodact prodact, String catId) async {
    String? ImageUrl;
    if (selectedImage != null) {
      ImageUrl = await StorageHelper.storageHelper.uploadImag(selectedImage!);
    }
    Prodact newpprodact = Prodact(
        description: productDescConteoller.text,
        name: productNameConteoller.text,
        price: num.parse(productPriceConteoller.text),
        quantity: int.parse(productQuantityConteoller.text),
        imag: ImageUrl ?? prodact.imag);
    newpprodact.id = prodact.id;
    await FirestorHelper.firestorHelper.updateProduct(newpprodact, catId);
    listproducts.remove(newpprodact);
    listproducts.add(prodact);
    notifyListeners();
    getAllProducts(catId);
  }

  deleteProduct(Prodact prodact, String catId) async {
    await FirestorHelper.firestorHelper.deleteProduct(prodact, catId);
    listproducts.remove(prodact);
    notifyListeners();

    getAllProducts(catId);
  }

  resetProdact() {
    selectedImage = null;
    productNameConteoller.clear();
    productDescConteoller.clear();
    productPriceConteoller.clear();
    productQuantityConteoller.clear();
  }
}
