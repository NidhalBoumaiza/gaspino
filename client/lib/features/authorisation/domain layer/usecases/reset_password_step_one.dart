import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class ResetPasswordStepOneUseCase {
  final UserRepository userRepository;

  ResetPasswordStepOneUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(String passwordResetCode) async {
    return await userRepository.resetPasswordStepOne(passwordResetCode);
  }
}
