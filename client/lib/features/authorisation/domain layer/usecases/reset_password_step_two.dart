import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class ResetPasswordStepTwoUseCase {
  final UserRepository userReposiroty;

  ResetPasswordStepTwoUseCase(this.userReposiroty);

  Future<Either<Failure, Unit>> call(
      String passwordResetCode, String password, String passwordConfirm) async {
    return await userReposiroty.resetPasswordStepTwo(
        passwordResetCode, password, passwordConfirm);
  }
}
