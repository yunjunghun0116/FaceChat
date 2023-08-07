import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UploadService {
  static final UploadService _instance = UploadService._internal();
  factory UploadService() => _instance;
  UploadService._internal();

  static Future<String?> uploadProfileImage({required XFile image}) async {
    try {
      DateTime nowDate = DateTime.now();
      String imageRef = '/profile/${nowDate.microsecondsSinceEpoch}';
      File file = File(image.path);
      TaskSnapshot task =
          await FirebaseStorage.instance.ref(imageRef).putFile(file);
      return await task.ref.getDownloadURL();
    } catch (e) {
      log('FirebaseUploadService - uploadProfileImage Failed : $e');
      return null;
    }
  }
}
