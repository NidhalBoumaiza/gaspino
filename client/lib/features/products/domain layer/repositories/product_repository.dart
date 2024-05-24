import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, Unit>> addProduct(Product product);

  Future<Either<Failure, List<Product>>> getMyProducts();

  Future<Either<Failure, Product>> updateMyProduct(Product product);

  Future<Either<Failure, Unit>> deleteMyProduct(String id);

  Future<Either<Failure, List<Product>>> getAllProductsWithinDistance(
      num distance);

  Future<Either<Failure, List<Product>>>
      getAllProductsWithinDistanceExpiresToday(num distance);

  Future<Either<Failure, List<Product>>> searchProductByName(String name);
}
