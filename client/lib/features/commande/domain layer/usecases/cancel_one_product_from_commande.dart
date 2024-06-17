import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/commande_repository.dart';

class CancelOneProductFromCommande {
  final CommandeRepository repository;

  CancelOneProductFromCommande(this.repository);

  Future<Either<Failure, Unit>> call(
      String commandeId, String productId) async {
    return await repository.cancelOneProductFromCommande(commandeId, productId);
  }
}
