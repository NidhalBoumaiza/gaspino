part of 'get_all_products_within_distance_bloc.dart';

@immutable
sealed class GetProductsWithinDistanceState extends Equatable {}

final class GetProductsWithinDistanceInitial
    extends GetProductsWithinDistanceState {
  @override
  List<Object?> get props => [];
}

final class GetProductsWithinDistanceLoading
    extends GetProductsWithinDistanceState {
  @override
  List<Object?> get props => [];
}

final class GetProductsWithinDistanceLoaded
    extends GetProductsWithinDistanceState {
  final List<Product> products;

  GetProductsWithinDistanceLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class GetProductsWithinDistanceError extends GetProductsWithinDistanceState {
  final String message;

  GetProductsWithinDistanceError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class GetProductsWithinDistanceUnauthorized
    extends GetProductsWithinDistanceState {
  @override
  List<Object?> get props => [];
}
