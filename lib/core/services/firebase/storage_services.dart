import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class StorageServices {
  static Future<String?> uploadAvatar(int uid) async {
    String ref = 'users/$uid/profile/avatar'.toLowerCase();
    print("ref: $ref");
    String? path = await openImagePicker();
    if (path != null) {
      String? url = await uploadFile(
        file: File(path),
        ref: ref,
      );
      return url;
    }
    return null;
  }

  static Future<String?> openImagePicker() async {
    try {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
      print("path: ${picked?.path}");
      return picked?.path;
    } on PlatformException catch (e) {
      print("ERROR Unsupported operation" + e.toString());
    } catch (e) {
      print('ERROR' + e.toString());
    }
    return null;
  }

  ///FUNCTION UPLOAD the file to the storage
  static Future<String?> uploadFile({required File file, required String ref}) async {
    Uint8List data = await file.readAsBytes();
    String extension = file.path.split(".").last;

    ///Start uploading
    firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance.ref("$ref.$extension");
    print("reference: $reference");

    ///Show the status of the upload
    firebase_storage.TaskSnapshot uploadTask = await reference.putData(data);

    ///Get the download url of the file
    String url = await uploadTask.ref.getDownloadURL();

    if (uploadTask.state == firebase_storage.TaskState.success) {
      print('done');
      print('URL: $url');
      return url;
    } else {
      print(uploadTask.state);
      return null;
    }
  }
}
