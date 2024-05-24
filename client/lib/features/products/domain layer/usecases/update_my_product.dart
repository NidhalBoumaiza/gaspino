import 'package:client/features/products/domain%20layer/entities/product.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class UpdateMyProduct {
  final ProductRepository repository;

  UpdateMyProduct(this.repository);

  @override
  Future<Either<Failure, Product>> call(Product product) async {
    return await repository.updateMyProduct(product);
  }
}
