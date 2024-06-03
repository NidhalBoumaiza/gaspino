part of 'delete_my_product_cubit.dart';

@immutable
sealed class DeleteMyProductState extends Equatable {}

final class DeleteMyProductInitial extends DeleteMyProductState {
  @override
  List<Object?> get props => [];
}

final class DeleteMyProductLoading extends DeleteMyProductState {
  @override
  List<Object?> get props => [];
}

final class DeleteMyProductSuccess extends DeleteMyProductState {
  final List<Product> products;

  DeleteMyProductSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

final class DeleteMyProductError extends DeleteMyProductState {
  final String message;

  DeleteMyProductError(this.message);

  @override
  List<Object?> get props => [message];
}

final class DeleteMyProductUnauthorized extends DeleteMyProductState {
  @override
  List<Object?> get props => [];
}
