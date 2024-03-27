import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> signUp(User user);

  Future<Either<Failure, Unit>> forgetPassword(String email);

  Future<Either<Failure, Unit>> resetPasswordStepOne(String passwordResetCode);

  Future<Either<Failure, Unit>> resetPasswordStepTwo(
      String passwordResetCode, String password, String passwordConfirm);

  Future<Either<Failure, User>> signIn(String email, String password);

//--------------------------------------------------------------------------------
  /// NEXT METHODS ARE FOR AUTHENTICATED USERS
  Future<Either<Failure, Unit>> updateUserPassword(
      String oldPassword, String newPassword, String newPasswordConfirm);

  Future<Either<Failure, Unit>> updateLocation(Location location);

  Future<Either<Failure, Unit>> disableMyAccount();

  Future<Either<Failure, Unit>> signOut();
}
