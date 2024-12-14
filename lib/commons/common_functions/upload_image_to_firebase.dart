import 'dart:io';

import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

// Future<String?> uploadImage({required File img,required String storageFolderName})async{
//   FirebaseStorage storage = FirebaseStorage.instance;
//   final Uint8List list = await img.readAsBytes();
//
//   try{
//       String name = const Uuid().v1();
//       Reference ref = storage.ref().child(storageFolderName).child(name);
//       UploadTask task = ref.putData(list);
//       final TaskSnapshot taskSnapshot = await task.whenComplete(() {});
//       final String url = await taskSnapshot.ref.getDownloadURL();
//       return url;
//
//
//   }on FirebaseException catch(e){
//     showToast(msg: e.message ?? '');
//     return null;
//   }
// }

Future<String?> uploadImage({
  required File img,
  required String storageFolderName,
  required String subFolderName,
}) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  final Uint8List list = await img.readAsBytes();

  try {
    String name = const Uuid().v1();
    Reference ref =
        storage.ref().child(storageFolderName).child(subFolderName).child(name);
    UploadTask task = ref.putData(list);
    final TaskSnapshot taskSnapshot = await task.whenComplete(() {});
    final String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  } on FirebaseException catch (e) {
    showToast(msg: e.message ?? '');
    return null;
  }
}

Future<List<String>> uploadImages(List<XFile> images,
    {required String storageFolderName, required subFolderName}) async {
  print(subFolderName);
  List<String> imgDownloadUrls = [];
  for (int i = 0; i < images.length; i++) {
    String imgUrl = await uploadXImage(images[i],
        storageFolderName: storageFolderName, subFolderName: subFolderName);
    imgDownloadUrls.add(imgUrl);
  }
  return imgDownloadUrls;
}

Future<String> uploadXImage(XFile image,
    {required String storageFolderName, required subFolderName}) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  var name = const Uuid().v4();
  final path =
      storage.ref().child(storageFolderName).child(subFolderName).child(name);
  // final path = _storage.ref().child(path);
  Uint8List imgInBytes = await image.readAsBytes();
  UploadTask uploadTask = path.putData(imgInBytes);
  TaskSnapshot snap = await uploadTask.whenComplete(() {});
  String downloadUrl = await snap.ref.getDownloadURL();
  return downloadUrl;
}
