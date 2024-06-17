part of 'get_my_ordered_products_bloc.dart';

abstract class GetMyOrderedProductsState extends Equatable {}

class GetMyOrderedProductsInitial extends GetMyOrderedProductsState {
  @override
  List<Object?> get props => [];
}

class GetMyOrderedProductsLoading extends GetMyOrderedProductsState {
  @override
  List<Object?> get props => [];
}

class GetMyOrderedProductsLoaded extends GetMyOrderedProductsState {
  final List<Commande> orderedProducts;

  GetMyOrderedProductsLoaded({required this.orderedProducts});

  @override
  List<Object?> get props => [orderedProducts];
}

class GetMyOrderedProductsError extends GetMyOrderedProductsState {
  final String message;

  GetMyOrderedProductsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetMyOrderedProductsNonAuthenticated extends GetMyOrderedProductsState {


  GetMyOrderedProductsNonAuthenticated();

  @override
  List<Object?> get props => [];
}
