import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';


// ...

Future<File?> cropImage(
    {required File imageFile, required BuildContext context}) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    // aspectRatioPresets: [
    //   CropAspectRatioPreset.square,
    //   CropAspectRatioPreset.ratio3x2,
    //   CropAspectRatioPreset.original,
    //   CropAspectRatioPreset.ratio4x3,
    //   CropAspectRatioPreset.ratio16x9,
    // ],
    // cropStyle: CropStyle.circle,
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Theme.of(context).colorScheme.onPrimary,
          toolbarWidgetColor: context.greenColor,
          initAspectRatio: CropAspectRatioPreset.original,
          activeControlsWidgetColor:  Theme.of(context).colorScheme.onPrimary,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ],
  );

  if (croppedFile != null) {
    return File(croppedFile.path);
  }
  return null;
}
