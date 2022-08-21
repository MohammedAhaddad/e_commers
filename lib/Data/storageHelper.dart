import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageHelper {
  StorageHelper._();
  static StorageHelper storageHelper = StorageHelper._();
  FirebaseStorage storage = FirebaseStorage.instance;
  Future uploadImag(File file) async {
    String FilleName = file.path.split('/').last;
    Reference reference = storage.ref('images/$FilleName');
    TaskSnapshot taskSnapshot = await reference.putFile(file);
    String imagUrl = await reference.getDownloadURL();
    return imagUrl;
  }
}
