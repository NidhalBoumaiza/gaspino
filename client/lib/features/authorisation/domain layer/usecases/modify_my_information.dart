import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class ModifyMyInformationUseCase {
  final UserRepository userRepository;

  ModifyMyInformationUseCase(this.userRepository);

  Future<Either<Failure, User>> call(User user) async {
    return await userRepository.modifyMyInformation(user);
  }
}
