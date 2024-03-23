import 'package:client/features/authorisation/domain%20layer/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class UpdateCoordinateUseCase {
  final UserRepository userRepository;

  UpdateCoordinateUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(Coordinate coordinate) async {
    return await userRepository.updateCoordinate(coordinate);
  }
}
