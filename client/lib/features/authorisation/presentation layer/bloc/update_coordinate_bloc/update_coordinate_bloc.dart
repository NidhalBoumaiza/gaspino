// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/entities/user.dart';
import '../../../domain layer/usecases/update_coordinate.dart';

part 'update_coordinate_event.dart';
part 'update_coordinate_state.dart';

class UpdateCoordinateBloc
    extends Bloc<UpdateCoordinateEvent, UpdateCoordinateState> {
  UpdateCoordinateUseCase updateCoordinateUseCase;

  UpdateCoordinateBloc({required this.updateCoordinateUseCase})
      : super(UpdateCoordinateInitial()) {
    on<UpdateCoordinateEvent>((event, emit) {});
    on<UpdateCoordinate>(_updateCoordinate);
  }

  _updateCoordinate(
      UpdateCoordinate event, Emitter<UpdateCoordinateState> emit) async {
    emit(UpdateCoordinateLoading());
    final failureOrUnit = await updateCoordinateUseCase(event.location);
    failureOrUnit.fold(
      (failure) =>
          emit(UpdateCoordinateError(message: mapFailureToMessage(failure))),
      (_) => emit(UpdateCoordinateSuccess()),
    );
  }
}
