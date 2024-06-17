import 'package:client/features/commande/domain%20layer/repositories/commande_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class UpdateProductStatusToDelivred {
  final CommandeRepository repository;

  UpdateProductStatusToDelivred(this.repository);

  Future<Either<Failure, Unit>> call(
      String commandeId, String productId) async {
    return await repository.updateProductStatusToDelivered(
        commandeId, productId);
  }
}
