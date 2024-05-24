import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProductsWithinDistanceExpiresTodayUseCase {
  final ProductRepository repository;

  GetAllProductsWithinDistanceExpiresTodayUseCase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(num distance) async {
    return await repository.getAllProductsWithinDistanceExpiresToday(distance);
  }
}
