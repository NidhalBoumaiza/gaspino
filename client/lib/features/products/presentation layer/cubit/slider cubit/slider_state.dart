part of 'slider_cubit.dart';

class SliderState extends Equatable {
  late double distance = 2;

  SliderState({required this.distance});

  @override
  List<Object?> get props => [distance];
}
