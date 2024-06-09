import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetCachedUserInfoUseCase {
  final UserRepository userRepository;

  GetCachedUserInfoUseCase(this.userRepository);

  Future<Either<Failure, User>> call() async {
    return await userRepository.getCachedUserInfo();
  }
}
