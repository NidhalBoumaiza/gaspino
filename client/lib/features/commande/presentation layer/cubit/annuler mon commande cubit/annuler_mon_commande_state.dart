part of 'annuler_mon_commande_cubit.dart';

abstract class AnnulerMonCommandeState extends Equatable {}

class AnnulerMonCommandeInitial extends AnnulerMonCommandeState {
  @override
  List<Object?> get props => [];
}

class AnnulerMonCommandeLoading extends AnnulerMonCommandeState {
  @override
  List<Object?> get props => [];
}

class AnnulerMonCommandeSuccess extends AnnulerMonCommandeState {
  final List<Commande> commande;

  AnnulerMonCommandeSuccess({required this.commande});

  @override
  List<Object?> get props => [commande];
}

class AnnulerMonCommandeError extends AnnulerMonCommandeState {
  final String message;

  AnnulerMonCommandeError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AnnulerMonCommandeUnauthorized extends AnnulerMonCommandeState {
  @override
  List<Object?> get props => [];
}
