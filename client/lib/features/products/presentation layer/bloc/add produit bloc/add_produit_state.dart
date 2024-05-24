part of 'add_produit_bloc.dart';

class AddProduitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddProduitInitial extends AddProduitState {
  @override
  List<Object?> get props => [];
}

class AddProduitLoading extends AddProduitState {
  @override
  List<Object?> get props => [];
}

class AddProduitSuccess extends AddProduitState {
  final String message;

  AddProduitSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddProduitError extends AddProduitState {
  final String message;

  AddProduitError({required this.message});

  @override
  List<Object?> get props => [message];
}
