part of 'profile_pic_creation__cubit.dart';

@immutable
class ProfilePicCreationState extends Equatable {
  dynamic img;
  String? croppedImage;

  ProfilePicCreationState({
    required this.img,
    this.croppedImage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [img];
}
