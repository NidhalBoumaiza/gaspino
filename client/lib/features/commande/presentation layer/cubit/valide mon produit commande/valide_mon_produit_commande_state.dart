part of 'valide_mon_produit_commande_cubit.dart';

abstract class ValideMonProduitCommandeState extends Equatable {}

class ValideMonProduitCommandeInitial extends ValideMonProduitCommandeState {
  @override
  List<Object?> get props => [];
}

class ValideMonProduitCommandeLoading extends ValideMonProduitCommandeState {
  @override
  List<Object?> get props => [];
}

class ValideMonProduitCommandeSuccess extends ValideMonProduitCommandeState {
  final List<Commande> commande;

  ValideMonProduitCommandeSuccess({required this.commande});

  @override
  List<Object?> get props => [commande];
}

class ValideMonProduitCommandeError extends ValideMonProduitCommandeState {
  final String message;

  ValideMonProduitCommandeError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ValideMonProduitCommandeUnauthorized
    extends ValideMonProduitCommandeState {
  @override
  List<Object?> get props => [];
}
