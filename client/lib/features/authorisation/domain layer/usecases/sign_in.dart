import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SignInUseCase {
  final UserRepository userRepository;

  SignInUseCase(this.userRepository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await userRepository.signIn(email, password);
  }
}
