import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderState(distance: 2));

  void changeDistance(double distance) {
    emit(SliderState(distance: distance));
  }
}
