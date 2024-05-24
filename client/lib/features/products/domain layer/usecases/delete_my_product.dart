import 'package:client/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/product_repository.dart';

class DeleteMyProduct {
  final ProductRepository repository;

  DeleteMyProduct(this.repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deleteMyProduct(id);
  }
}
