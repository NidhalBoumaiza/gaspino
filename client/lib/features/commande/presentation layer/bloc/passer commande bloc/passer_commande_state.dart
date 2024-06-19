part of 'passer_commande_bloc.dart';


abstract class PasserCommandeState extends Equatable {}

class PasserCommandeInitial extends PasserCommandeState {
  @override
  List<Object?> get props => [];
}

class PasserCommandeLoading extends PasserCommandeState {
  @override
  List<Object?> get props => [];
}

class PasserCommandeSuccess extends PasserCommandeState {
  final String message;

  PasserCommandeSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class PasserCommandeError extends PasserCommandeState {
  final String message;

  PasserCommandeError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PasserCommandeUnauthorised extends PasserCommandeState {

  PasserCommandeUnauthorised();

  @override
  List<Object?> get props => [];
}
