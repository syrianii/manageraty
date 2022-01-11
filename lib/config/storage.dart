import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  FirebaseStorage storage;

  intialize() {
    storage = FirebaseStorage.instance;
  }

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      storage.ref('users_profile_pic/$fileName').putFile(file);
    } catch (e) {
      print(e);
    }
  }

  Future <void> downloadFile(String fileName) async{
    String image = await storage.ref('users_profile_pic/$fileName').getDownloadURL();
    return image;
  }
}
