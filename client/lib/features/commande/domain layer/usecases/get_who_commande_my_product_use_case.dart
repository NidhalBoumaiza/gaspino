import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/commande.dart';
import '../repositories/commande_repository.dart';

class GetWhoCommandeMyProductUseCase {
  final CommandeRepository _commandeRepository;

  GetWhoCommandeMyProductUseCase(this._commandeRepository);

  Future<Either<Failure, List<Commande>>> call() {
    return _commandeRepository.getWhoCommandedMyProduct();
  }
}
