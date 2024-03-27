import '../../domain layer/entities/user.dart';

class UserModel extends User {
  UserModel(
    String id,
    String profilePicture,
    String firstName,
    String lastName,
    String PhoneNumber,
    String email,
    String password,
    String passwordConfirm,
    Location location,
    String passwordResetCode,
    bool accountStatus,
  ) : super(
          id,
          profilePicture,
          firstName,
          lastName,
          PhoneNumber,
          email,
          password,
          passwordConfirm,
          location,
          passwordResetCode,
          accountStatus,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['_id'] ?? '',
      json['profilePicture'] ?? '',
      json['firstName'] ?? '',
      json['lastName'] ?? '',
      json['phoneNumber'] ?? '',
      json['email'] ?? '',
      json['password'] ?? '',
      json['passwordConfirm'] ?? '',
      Location(
        json['location'] != null
            ? (json['location']['coordinates'] as List<dynamic>)
                .map((e) => num.parse(e.toString()))
                .toList()
            : [0.0, 0.0],
      ),
      json['passwordResetCode'] ?? '',
      json['accountStatus'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profilePicture': profilePicture,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'passwordConfirm': passwordConfirm,
      'location': {
        'coordinates': location.coordinates,
      },
      'passwordResetCode': passwordResetCode,
      'accountStatus': accountStatus,
    };
  }
}
