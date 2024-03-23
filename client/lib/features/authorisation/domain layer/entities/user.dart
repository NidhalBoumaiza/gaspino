import 'package:equatable/equatable.dart';

class User extends Equatable {
  late final String id;
  late String profilePicture;
  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String passwordConfirm;
  late Coordinate coordinate;
  late String passwordResetCode;
  late bool accountStatus;

  User(
    this.id,
    this.profilePicture,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.passwordConfirm,
    this.coordinate,
    this.passwordResetCode,
    this.accountStatus,
  );

  User.create({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.passwordConfirm,
  }) {
    id = '';
    profilePicture = '';
    coordinate = Coordinate(0, 0);
    passwordResetCode = '';
    accountStatus = false;
  }

  @override
  List<Object?> get props => [
        id,
        profilePicture,
        firstName,
        lastName,
        email,
        password,
        passwordConfirm,
        coordinate,
        passwordResetCode,
        accountStatus,
      ];
}

class Coordinate extends Equatable {
  late double latitude;
  late double longitude;

  Coordinate(
    this.latitude,
    this.longitude,
  );

  @override
  List<Object?> get props => [latitude, longitude];
}
