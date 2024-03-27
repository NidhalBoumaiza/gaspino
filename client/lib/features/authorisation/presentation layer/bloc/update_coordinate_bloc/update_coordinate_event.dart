part of 'update_coordinate_bloc.dart';

abstract class UpdateCoordinateEvent extends Equatable {}

class UpdateCoordinate extends UpdateCoordinateEvent {
  Location location;

  UpdateCoordinate({required this.location});

  @override
  List<Object?> get props => [location];
}
