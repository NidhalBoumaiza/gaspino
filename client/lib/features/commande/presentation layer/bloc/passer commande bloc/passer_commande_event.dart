part of 'passer_commande_bloc.dart';

abstract class PasserCommandeEvent extends Equatable {}

class PasserCommande extends PasserCommandeEvent {
  dynamic products;

  PasserCommande({required this.products});

  @override
  List<Object?> get props => [products];
}
