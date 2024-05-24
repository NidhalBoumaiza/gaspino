import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'first_image_state.dart';

class FirstImageCubit extends Cubit<FirstImageState> {
  FirstImageCubit() : super(FirstImageState(img: []));

  void changeImage(dynamic img, String croppedImage) {
    List<String> splitString = img.split(",");
    final image = base64Decode(splitString[1]);
    final updatedImages = List<dynamic>.from(state.img)..add(image);
    final updatedImagesToSendToBackend =
        List<String>.from(state.croppedImage ?? [])..add(croppedImage);
    final updatedState = FirstImageState(
        img: updatedImages, croppedImage: updatedImagesToSendToBackend);
    emit(updatedState);
  }

  void removeImage(int index) {
    if (index >= 0 && index < state.img.length) {
      final updatedImages = List<dynamic>.from(state.img)..removeAt(index);
      final updatedImagesToSendToBackend =
          List<String>.from(state.croppedImage ?? [])..removeAt(index);
      final updatedState = FirstImageState(
          img: updatedImages, croppedImage: updatedImagesToSendToBackend);
      emit(updatedState);
    }
  }
}
