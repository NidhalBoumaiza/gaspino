import 'dart:convert';
import 'dart:io';

import 'package:client/core/widgets/reusable_text_field_widget.dart';
import 'package:client/features/products/presentation%20layer/bloc/add%20produit%20bloc/add_produit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/svg.dart';
import '../../../../../core/widgets/my_customed_button.dart';
import '../../../../../core/widgets/reusable_text.dart';
import '../../../../authorisation/domain layer/entities/user.dart';
import '../../../domain layer/entities/product.dart';
import '../../cubit/first image cubit/first_image_cubit.dart';
import '../../widgets/add_image.dart';
import '../../widgets/circularProgressiveIndicator.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController originalPriceController = TextEditingController();
  final TextEditingController sellPriceController = TextEditingController();
  final TextEditingController quantityForSaleController =
      TextEditingController();
  final TextEditingController expirationDateController =
      TextEditingController();
  final TextEditingController startingDateController = TextEditingController();
  final TextEditingController endingDateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime expirationDate = DateTime.now();
  DateTime? startingDate;

  DateTime? endingDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: ReusableText(
            text: "Ajouter produit",
            textSize: 18.sp,
            textColor: Colors.white,
            textFontWeight: FontWeight.w700,
          ),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: "Images de Produits :",
                          textSize: 13.sp,
                          textColor: Colors.grey[700]!,
                          textFontWeight: FontWeight.w600),
                      SizedBox(height: 5.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocBuilder<FirstImageCubit, FirstImageState>(
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: state.img.isEmpty
                                      ? () {
                                          showImagePicker(context);
                                        }
                                      : null,
                                  child: AddImage(
                                      height: SizeScreen.height * 0.138,
                                      width: SizeScreen.width * 0.28,
                                      image: state.img.isNotEmpty
                                          ? state.img[0]
                                          : null,
                                      onPress: () {
                                        context
                                            .read<FirstImageCubit>()
                                            .removeImage(0);
                                      }),
                                );
                              },
                            ),
                            BlocBuilder<FirstImageCubit, FirstImageState>(
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: state.img.length == 1
                                      ? () {
                                          showImagePicker(context);
                                        }
                                      : null,
                                  child: AddImage(
                                      height: SizeScreen.height * 0.138,
                                      width: SizeScreen.width * 0.28,
                                      image: state.img.length > 1
                                          ? state.img[1]
                                          : null,
                                      onPress: () {
                                        context
                                            .read<FirstImageCubit>()
                                            .removeImage(1);
                                      }),
                                );
                              },
                            ),
                            BlocBuilder<FirstImageCubit, FirstImageState>(
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: state.img.length == 2
                                      ? () {
                                          showImagePicker(context);
                                        }
                                      : null,
                                  child: AddImage(
                                      height: SizeScreen.height * 0.138,
                                      width: SizeScreen.width * 0.28,
                                      image: state.img.length > 2
                                          ? state.img[2]
                                          : null,
                                      onPress: () {
                                        context
                                            .read<FirstImageCubit>()
                                            .removeImage(2);
                                      }),
                                );
                              },
                            ),
                          ]),
                      SizedBox(height: 10.h),
                      ReusableText(
                          text: "Nom du produits : *",
                          textSize: 13.sp,
                          textColor: Colors.grey[700]!,
                          textFontWeight: FontWeight.w600),
                      SizedBox(height: 5.h),
                      ReusableTextFieldWidget(
                        controller: nameController,
                        hintText: "Nom du produit",
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      SizedBox(height: 10.h),
                      ReusableText(
                          text: "Description du produit :",
                          textSize: 13.sp,
                          textColor: Colors.grey[700]!,
                          textFontWeight: FontWeight.w600),
                      SizedBox(height: 5.h),
                      ReusableTextFieldWidget(
                        controller: descriptionController,
                        hintText: "Description du produit",
                        borderSide: const BorderSide(color: Colors.grey),
                        maxLines: 4,
                        minLines: 2,
                      ),
                      SizedBox(height: 10.h),
                      // PRICE SECTION
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                    text: "Prix original:",
                                    textSize: 13.sp,
                                    textColor: Colors.grey[700]!,
                                    textFontWeight: FontWeight.w600),
                                ReusableTextFieldWidget(
                                  textAlignProperty: TextAlign.center,
                                  controller: originalPriceController,
                                  hintText: "Prix original",
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                    text: "Prix de vente: *",
                                    textSize: 13.sp,
                                    textColor: Colors.grey[700]!,
                                    textFontWeight: FontWeight.w600),
                                ReusableTextFieldWidget(
                                  textAlignProperty: TextAlign.center,
                                  controller: sellPriceController,
                                  hintText: "Prix de vente",
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // QUANTITY
                      SizedBox(height: 10.h),
                      ReusableText(
                          text: "Quantité : *",
                          textSize: 13.sp,
                          textColor: Colors.grey[700]!,
                          textFontWeight: FontWeight.w600),
                      SizedBox(height: 5.h),
                      ReusableTextFieldWidget(
                        controller: quantityForSaleController,
                        hintText: "Quantité disponible de produit",
                        borderSide: const BorderSide(color: Colors.grey),
                        keyboardType: TextInputType.number,
                      ),
                      // EXPIRATION DATE
                      SizedBox(height: 10.h),
                      ReusableText(
                          text: "Date d'expiration : *",
                          textSize: 13.sp,
                          textColor: Colors.grey[700]!,
                          textFontWeight: FontWeight.w600),
                      SizedBox(height: 5.h),
                      GestureDetector(
                        onTap: () async {
                          DateTime? expirationDate = await showDateTimePicker(
                            context,
                            DateTime.now(),
                            DateTime.now(),
                            DateTime(3000),
                            false,
                          );
                          if (expirationDate != null) {
                            expirationDateController.text =
                                "${expirationDate.day}/${expirationDate.month}/${expirationDate.year}";
                          }
                        },
                        child: ReusableTextFieldWidget(
                          enabled: false,
                          prefixIcon: FontAwesomeIcons.hourglassEnd,
                          controller: expirationDateController,
                          hintText: "Date d'expiration...",
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ReusableText(
                          text: "Date de récupération :",
                          textSize: 13.sp,
                          textColor: Colors.grey[700]!,
                          textFontWeight: FontWeight.w600),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                    text: "De: ",
                                    textSize: 13.sp,
                                    textColor: Colors.grey[700]!,
                                    textFontWeight: FontWeight.w600),
                                GestureDetector(
                                  onTap: () async {
                                    startingDate = await showDateTimePicker(
                                      context,
                                      DateTime.now(),
                                      DateTime.now(),
                                      DateTime(3000),
                                      true,
                                    );
                                    if (startingDate != null) {
                                      startingDateController.text =
                                          "${startingDate!.day}/${startingDate!.month}/${startingDate!.year} ${startingDate!.hour}:${startingDate!.minute} ";
                                    }
                                  },
                                  child: ReusableTextFieldWidget(
                                    enabled: false,
                                    textAlignProperty: TextAlign.center,
                                    controller: startingDateController,
                                    hintText: "De",
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                    text: "Jusqu'à:",
                                    textSize: 13.sp,
                                    textColor: Colors.grey[700]!,
                                    textFontWeight: FontWeight.w600),
                                GestureDetector(
                                  onTap: () async {
                                    endingDate = await showDateTimePicker(
                                      context,
                                      DateTime.now(),
                                      DateTime.now(),
                                      DateTime(3000),
                                      true,
                                    );
                                    if (endingDate != null) {
                                      endingDateController.text =
                                          "${endingDate!.day}/${endingDate!.month}/${endingDate!.year} ${endingDate!.hour}:${endingDate!.minute} ";
                                    }
                                  },
                                  child: ReusableTextFieldWidget(
                                    enabled: false,
                                    textAlignProperty: TextAlign.center,
                                    controller: endingDateController,
                                    hintText: "Jusq'à",
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                BlocConsumer<AddProduitBloc, AddProduitState>(
                  listener: (context, state) {
                    if (state is AddProduitSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    } else if (state is AddProduitError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return MyCustomButton(
                      width: SizeScreen.width,
                      height: 50.h,
                      function: () {
                        FocusScope.of(context).unfocus();
                        if (nameController.text.isNotEmpty &&
                            sellPriceController.text.isNotEmpty &&
                            quantityForSaleController.text.isNotEmpty &&
                            expirationDateController.text.isNotEmpty) {
                          Product product = Product.create(
                            productPictures: context
                                    .read<FirstImageCubit>()
                                    .state
                                    .croppedImage ??
                                [],
                            name: nameController.text,
                            priceAfterReduction: double.parse(
                                sellPriceController.text.replaceAll(",", ".")),
                            quantity: int.parse(quantityForSaleController.text),
                            expirationDate: expirationDate,
                            recoveryDate: [startingDate, endingDate],
                            location: Location([36.418815, 10.655665]),
                            description: descriptionController.text,
                            priceBeforeReduction:
                                originalPriceController.text != ""
                                    ? double.parse(originalPriceController.text
                                        .replaceAll(",", "."))
                                    : 0,
                          );
                          context
                              .read<AddProduitBloc>()
                              .add(AddProduitButtonPressed(product: product));
                        }
                      },
                      buttonColor: primaryColor,
                      text: "Ajouter produit",
                      widget: state is AddProduitLoading
                          ? ReusablecircularProgressIndicator(
                              indicatorColor: Colors.white)
                          : const SizedBox(),
                      circularRadious: 15.sp,
                      textButtonColor: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    );
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff284F7B)),
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
      context.read<FirstImageCubit>().changeImage(base64Data, croppedFile.path);
    }
  }

  Future<String> fileToBase64(File file) async {
    List<int> fileBytes = await file.readAsBytes();
    String base64Image = base64Encode(fileBytes);
    return base64Image;
  }
}

Future<DateTime?> showDateTimePicker(BuildContext context, DateTime initilaDate,
    DateTime firstDate, DateTime lastDate, bool isShowTimePicker) async {
  final date = await showDatePicker(
    context: context,
    initialDate: initilaDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (date == null) {
    return null;
  }
  if (!isShowTimePicker) {
    return date;
  }
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
  );

  if (time == null) {
    return null;
  }

  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}
