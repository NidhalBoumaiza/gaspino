import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class SearchProductByNameUseCase {
  final ProductRepository repository;

  SearchProductByNameUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call(String name) async {
    return await repository.searchProductByName(name);
  }
}
