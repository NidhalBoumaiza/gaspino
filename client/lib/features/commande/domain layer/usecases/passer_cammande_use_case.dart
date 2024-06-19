import 'package:client/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/commande_repository.dart';

class PasserCommandeUseCase {
  final CommandeRepository commandeRepository;

  PasserCommandeUseCase(this.commandeRepository);

  Future<Either<Failure, Unit>> call(dynamic commande) async {
    return commandeRepository.passerCommande(commande);
  }
}
