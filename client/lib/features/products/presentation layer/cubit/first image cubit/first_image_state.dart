part of 'first_image_cubit.dart';

class FirstImageState extends Equatable {
  List<dynamic> img;
  List<String>? croppedImage;

  FirstImageState({
    required this.img,
    this.croppedImage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [img];
}
