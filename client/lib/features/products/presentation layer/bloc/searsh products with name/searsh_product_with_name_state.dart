part of 'searsh_product_with_name_bloc.dart';

abstract class SearshProductWithNameState extends Equatable {}

class SearshProductWithNameInitial extends SearshProductWithNameState {
  @override
  List<Object> get props => [];
}

class SearshProductWithNameLoading extends SearshProductWithNameState {
  @override
  List<Object> get props => [];
}

class SearshProductWithNameLoaded extends SearshProductWithNameState {
  final List<Product> products;

  SearshProductWithNameLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class SearshProductWithNameError extends SearshProductWithNameState {
  final String message;

  SearshProductWithNameError({required this.message});

  @override
  List<Object> get props => [message];
}

class SearshProductWithNameUnauthorized extends SearshProductWithNameState {
  @override
  List<Object> get props => [];
}
