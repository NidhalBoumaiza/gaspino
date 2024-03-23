import 'package:client/features/authorisation/domain%20layer/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class DisableAccountUseCase {
  UserRepository userRepository;

  DisableAccountUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call() async {
    return await userRepository.disableMyAccount();
  }
}
