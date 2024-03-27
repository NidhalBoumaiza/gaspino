import 'package:equatable/equatable.dart';

class User extends Equatable {
  late final String id;
  late String profilePicture;
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String email;
  late String password;
  late String passwordConfirm;
  late Location location;
  late String passwordResetCode;
  late bool accountStatus;

  User(
    this.id,
    this.profilePicture,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.password,
    this.passwordConfirm,
    this.location,
    this.passwordResetCode,
    this.accountStatus,
  );

  User.create({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.passwordConfirm,
  }) {
    id = '';
    profilePicture = '';
    location = Location([0, 0]);
    passwordResetCode = '';
    accountStatus = false;
  }

  @override
  List<Object?> get props => [
        id,
        profilePicture,
        firstName,
        lastName,
        phoneNumber,
        email,
        password,
        passwordConfirm,
        location,
        passwordResetCode,
        accountStatus,
      ];
}

class Location extends Equatable {
  late List<num> coordinates;

  Location(
    this.coordinates,
  );

  @override
  List<Object?> get props => [coordinates];
}
