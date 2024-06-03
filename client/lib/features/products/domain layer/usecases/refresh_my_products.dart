import 'package:client/features/products/domain%20layer/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';

class RefreshMyProductsUseCase {
  ProductRepository repository;

  RefreshMyProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call() {
    return repository.getMyProducts();
  }
}
