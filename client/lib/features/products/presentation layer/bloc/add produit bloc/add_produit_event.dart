part of 'add_produit_bloc.dart';

class AddProduitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AddProduitButtonPressed extends AddProduitEvent {
  late Product product;

  AddProduitButtonPressed({required this.product});

  @override
  List<Object?> get props => [product];
}
