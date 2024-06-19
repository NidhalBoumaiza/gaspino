import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/commande.dart';

abstract class CommandeRepository {
  Future<Either<Failure, Unit>> passerCommande(dynamic commande);

  Future<Either<Failure, List<Commande>>> getMyCommandes();

  Future<Either<Failure, List<Commande>>> getWhoCommandedMyProduct();

  Future<Either<Failure, Unit>> cancelOneProductFromCommande(
      String commandeId, String productId);

  Future<Either<Failure, Unit>> updateProductStatusToDelivered(
      String commandeId, String productId);
}
