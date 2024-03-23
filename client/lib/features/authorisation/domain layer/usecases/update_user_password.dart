import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class UpdateUserPasswordUseCase {
  final UserRepository userRepository;

  UpdateUserPasswordUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(
      String oldPassword, String newPaswword, String confirmNewPaswword) async {
    return await userRepository.updateUserPassword(
        oldPassword, newPaswword, confirmNewPaswword);
  }
}
