import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SignUpUseCase {
  final UserRepository userRepository;

  SignUpUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(User user) async {
    return await userRepository.signUp(user);
  }
}
