import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class FireBaseStorage {
  static final String _avatars = "avatars/";
  static final String _reviews = "reviews/";
  static final _instance = firebase_storage.FirebaseStorage.instance;

  /// save image to Firebase Storage
  static Future<firebase_storage.Reference?> saveAvatar(
      File avatar, User user) async {
    final String extension = path.extension(avatar.path);

    /// save some metadata
    firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(
      contentType: 'image',
      customMetadata: <String, String>{
        'file-extension': extension,
      },
    );

    ///save image
    try {
      final result = await _instance
          .ref('$_avatars${user.uid}$extension')
          .putFile(avatar, metadata);
      print("Reference: ${result.ref}");
      return result.ref;
    } on firebase_storage.FirebaseException catch (e) {
      print('Failed to save avatar');
      print(() => log(e.code));
      return null;
    }
  }

  /// Upload a image in reviews bucket and return the
  /// image download links
  static Future<String> uploadFile(File _image, String uid, int index) async {
    final String extension = path.extension(_image.path);
    /// save some metadata
    firebase_storage.SettableMetadata metadata =
    firebase_storage.SettableMetadata(
      contentType: 'image',
      customMetadata: <String, String>{
        'file-extension': extension,
        'bucket': 'review images'
      },
    );
    final Reference storageReference = _instance.ref("$_reviews${uid}_$index$extension");
    final firebase_storage.UploadTask uploadTask = storageReference.putFile(_image, metadata);
    await uploadTask;
    return await storageReference.getDownloadURL();
  }

  /// Upload List of image to Reviews Bucket
  /// Return List of downloadable image URLs
  static Future<List<String>> uploadFilesAndGetUrls(List<File> _images, String uid) async {
    int index  = 0;
    List<String> imageUrls = await Future.wait(_images.map((_image) {
      return uploadFile(_image, uid, index++);
    }));
    return imageUrls;
  }
  ///get image url
  static Future<String?> getAvatar(String ref) async {
    try {
      final results = await _instance.ref(ref).getDownloadURL();
      print('Url : $results');
      return results;
    } on firebase_storage.FirebaseException catch (e) {
      print('Failed to get avatar url');
      print(() => log(e.code));
      return null;
    }
  }

  static Future<String> getDownloadLink(String ref) async {
    return await _instance.ref(ref).getDownloadURL();
  }

  FireBaseStorage._();
}
// firebase_storage.FirebaseException
