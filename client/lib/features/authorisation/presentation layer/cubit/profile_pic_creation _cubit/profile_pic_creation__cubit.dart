import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'profile_pic_creation__state.dart';

class ProfilePicCreationCubit extends Cubit<ProfilePicCreationState> {
  ProfilePicCreationCubit() : super(ProfilePicCreationState(img: null));

  void changeImage(dynamic img, String croppedImage) {
    List<String> splitString = img.split(",");
    final image = base64Decode(splitString[1]);
    final updatedState =
        ProfilePicCreationState(img: image, croppedImage: croppedImage);
    emit(updatedState);
  }
}
