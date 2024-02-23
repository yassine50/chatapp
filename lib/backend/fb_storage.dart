import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_native_image/flutter_native_image.dart';

class FB_Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Upload_File(String filePath, String fileName) async {
    bool verif = true;
   // File file = File(filePath);
    File compressedFile = await FlutterNativeImage.compressImage(filePath, quality: 5,);
    try {
      await storage.ref("${""}$fileName").putFile(compressedFile);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      verif = false;
    }
    return verif;
  }

  static bool verif_file = true;
  Future<String> Get_file(String fileName) async {
    try {
      String url = await storage
          .ref("${""}$fileName")
          .getDownloadURL();
      return url;
    } on firebase_core.FirebaseException catch (e) {
      verif_file = false;
      throw Exception(e);
    }
  }
}
