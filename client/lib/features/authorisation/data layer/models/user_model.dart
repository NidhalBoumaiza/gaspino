import '../../domain layer/entities/user.dart';

class UserModel extends User {
  UserModel(
    String id,
    String profilePicture,
    String firstName,
    String lastName,
    String email,
    String password,
    String passwordConfirm,
    Coordinate coordinate,
    String passwordResetCode,
    bool accountStatus,
  ) : super(
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
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        json['_id'] ?? '',
        json['profilePicture'] ?? '',
        json['firstName'] ?? '',
        json['lastName'] ?? '',
        json['email'] ?? '',
        json['password'] ?? '',
        json['passwordConfirm'] ?? '',
        Coordinate(
          json['coordinate']['latitude'] ?? 0.0,
          json['coordinate']['longitude'] ?? 0.0,
        ),
        json['passwordResetCode'] ?? '',
        json['accountStatus'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profilePicture': profilePicture,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'passwordConfirm': passwordConfirm,
      'coordinate': {
        'latitude': coordinate.latitude,
        'longitude': coordinate.longitude,
      },
      'passwordResetCode': passwordResetCode,
      'accountStatus': accountStatus,
    };
  }
}
