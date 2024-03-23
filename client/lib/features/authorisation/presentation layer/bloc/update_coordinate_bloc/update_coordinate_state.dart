part of 'update_coordinate_bloc.dart';

abstract class UpdateCoordinateState extends Equatable {}

final class UpdateCoordinateInitial extends UpdateCoordinateState {
  @override
  List<Object?> get props => [];
}

final class UpdateCoordinateLoading extends UpdateCoordinateState {
  @override
  List<Object?> get props => [];
}

final class UpdateCoordinateSuccess extends UpdateCoordinateState {
  @override
  List<Object?> get props => [];
}

final class UpdateCoordinateError extends UpdateCoordinateState {
  final String message;

  UpdateCoordinateError({required this.message});

  @override
  List<Object?> get props => [message];
}
