part of 'get_my_orders_bloc.dart';

abstract class GetMyOrdersState extends Equatable {}

class GetMyOrdersInitial extends GetMyOrdersState {
  @override
  List<Object?> get props => [];
}

class GetMyOrdersLoading extends GetMyOrdersState {
  @override
  List<Object?> get props => [];
}

class GetMyOrdersLoaded extends GetMyOrdersState {
  final List<Commande> commandes;

  GetMyOrdersLoaded({required this.commandes});

  @override
  List<Object?> get props => [commandes];
}

class GetMyOrdersError extends GetMyOrdersState {
  final String message;

  GetMyOrdersError({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetMyOrdersUnauthenticated extends GetMyOrdersState {
  @override
  List<Object?> get props => [];
}
