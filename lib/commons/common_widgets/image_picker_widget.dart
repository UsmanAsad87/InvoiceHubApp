import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';

// XFile? _imageFile;
// XFile? get imageFile => _imageFile;
// Future<XFile?> getImageFile()async{
//   ImagePicker picker = ImagePicker();
//   XFile? response = await picker.pickImage(source: ImageSource.gallery);
//   if(response!= null){
//     return response;
//   }else{
//     showToast(msg: 'Image not selected!');
//     return null;
//   }
// }

Future<File?> pickImageFromCamera(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      image= File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }

  return image;
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image= File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }

  return image;
}
