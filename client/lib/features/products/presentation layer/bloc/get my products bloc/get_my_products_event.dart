part of 'get_my_products_bloc.dart';

@immutable
sealed class GetMyProductsEvent extends Equatable {}

class GetMyProducts extends GetMyProductsEvent {
  @override
  List<Object?> get props => [];
}

class GetMyProductsRefresh extends GetMyProductsEvent {
  @override
  List<Object?> get props => [];
}
