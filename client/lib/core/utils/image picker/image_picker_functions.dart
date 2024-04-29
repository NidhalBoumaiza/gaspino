import 'dart:convert';
import 'dart:io';

import 'package:client/features/authorisation/presentation%20layer/cubit/profile_pic_creation%20_cubit/profile_pic_creation__cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();

void showImagePicker(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.11,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: InkWell(
                  child: const Column(
                    children: [
                      Icon(Icons.image, size: 32.0, color: Color(0xff284F7B)),
                      SizedBox(height: 5.0),
                      Text(
                        "Galerie",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff284F7B)),
                      )
                    ],
                  ),
                  onTap: () {
                    _imgFromGallery(context);
                    Get.back();
                  },
                )),
                Expanded(
                    child: InkWell(
                  child: const SizedBox(
                    child: Column(
                      children: [
                        Icon(Icons.camera_alt,
                            size: 32.0, color: Color(0xff284F7B)),
                        SizedBox(height: 5.0),
                        Text(
                          "Caméra",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff284F7B)),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    _imgFromCamera(context);
                    Get.back();
                  },
                ))
              ],
            ));
      });
}

_imgFromGallery(BuildContext context) async {
  await picker
      .pickImage(source: ImageSource.gallery, imageQuality: 50)
      .then((value) {
    if (value != null) {
      _cropImage(File(value.path), context);
    }
  });
}

_imgFromCamera(BuildContext context) async {
  await picker
      .pickImage(source: ImageSource.camera, imageQuality: 50)
      .then((value) {
    if (value != null) {
      _cropImage(File(value.path), context);
    }
  });
}

_cropImage(File imgFile, BuildContext context) async {
  final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: "Sélectionnez l'image",
            toolbarColor: const Color(0xff284F7B),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: "Sélectionnez l'image",
        )
      ]);
  if (croppedFile != null) {
    imageCache.clear();
    String base64Data = await fileToBase64(File(croppedFile.path));
    base64Data = "data:image/png;base64,$base64Data";
    context
        .read<ProfilePicCreationCubit>()
        .changeImage(base64Data, croppedFile.path);
  }
}

Future<String> fileToBase64(File file) async {
  List<int> fileBytes = await file.readAsBytes();
  String base64Image = base64Encode(fileBytes);
  return base64Image;
}
