part of 'get_all_products_within_distance_bloc.dart';

@immutable
sealed class GetProductsWithinDistanceEvent extends Equatable {}

class GetProductsWithinDistancee extends GetProductsWithinDistanceEvent {
  late num? distance;

  GetProductsWithinDistancee({required this.distance});

  @override
  List<Object?> get props => [distance];
}

class RefreshGetProductsWithinDistancee extends GetProductsWithinDistanceEvent {
  late double? distance;

  RefreshGetProductsWithinDistancee({required this.distance});

  @override
  List<Object?> get props => [distance];
}
