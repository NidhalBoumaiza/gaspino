part of 'update_coordinate_bloc.dart';

abstract class UpdateCoordinateEvent extends Equatable {}

class UpdateCoordinate extends UpdateCoordinateEvent {
  Coordinate coordinate;

  UpdateCoordinate({required this.coordinate});

  @override
  List<Object?> get props => [coordinate];
}
