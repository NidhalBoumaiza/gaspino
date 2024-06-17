import 'package:client/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/commande.dart';
import '../repositories/commande_repository.dart';

class GetMyCommandesUseCase {
  final CommandeRepository commandeRepository;

  GetMyCommandesUseCase(this.commandeRepository);

  Future<Either<Failure, List<Commande>>> call() {
    return commandeRepository.getMyCommandes();
  }
}
