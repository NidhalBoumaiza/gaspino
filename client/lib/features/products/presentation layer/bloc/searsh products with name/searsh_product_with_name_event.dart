part of 'searsh_product_with_name_bloc.dart';

abstract class SearshProductWithNameEvent extends Equatable {}

class SearshProductWithName extends SearshProductWithNameEvent {
  final String name;

  SearshProductWithName({required this.name});

  @override
  List<Object> get props => [name];
}

class Initialiser extends SearshProductWithNameEvent {
  @override
  List<Object?> get props => [];
}
