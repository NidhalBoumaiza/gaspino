part of 'get_products_expires_today_bloc.dart';

@immutable
sealed class GetProductsEpiresTodayEvent extends Equatable {}

class GetProductsWithinDistanceee extends GetProductsEpiresTodayEvent {
  late num? distance;

  GetProductsWithinDistanceee({required this.distance});

  @override
  List<Object?> get props => [distance];
}

class RefreshGetProductsWithinDistanceee extends GetProductsEpiresTodayEvent {
  late double? distance;

  RefreshGetProductsWithinDistanceee({required this.distance});

  @override
  List<Object?> get props => [distance];
}
