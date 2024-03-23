import 'package:client/features/authorisation/domain%20layer/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class ForgetPasswordUseCase {
  final UserRepository userRepository;

  ForgetPasswordUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(String email) async {
    return await userRepository.forgetPassword(email);
  }
}
