// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:client/features/authorisation/domain%20layer/entities/user.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/function_get_location.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
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

  _updateCoordinate(UpdateCoordinate event,
      Emitter<UpdateCoordinateState> emit) async {
    emit(UpdateCoordinateLoading());
    dynamic coordinate = await getCurrentLocation();
    if (coordinate == null) {
      emit(
          UpdateCoordinateError(message: 'Vous devez activer la localisation'));
      return;
    }
    print("test");
    print(coordinate);
    print(coordinate.latitude);
    Location location = Location([coordinate.longitude, coordinate.latitude]);
    final failureOrUnit = await updateCoordinateUseCase(location);
    failureOrUnit.fold(
          (failure) {
        if (failure is UnauthorizedFailure) {
          emit(UpdateCoordinateUnauthorized(
              message: mapFailureToMessage(failure)));
        } else {
          emit(UpdateCoordinateError(message: mapFailureToMessage(failure)));
        }
      },
          (_) => emit(UpdateCoordinateSuccess()),
    );
  }
}
