import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/entities/product.dart';
import '../../../domain layer/usecases/search_product_by_name.dart';

part 'searsh_product_with_name_event.dart';
part 'searsh_product_with_name_state.dart';

class SearshProductWithNameBloc
    extends Bloc<SearshProductWithNameEvent, SearshProductWithNameState> {
  SearchProductByNameUseCase searshProductWithNameUseCase;

  SearshProductWithNameBloc({required this.searshProductWithNameUseCase})
      : super(SearshProductWithNameInitial()) {
    on<SearshProductWithNameEvent>((event, emit) {});
    on<SearshProductWithName>(_searchProductWithName);
    on<Initialiser>((event, emit) {
      emit(SearshProductWithNameInitial());
    });
  }

  _searchProductWithName(SearshProductWithName event,
      Emitter<SearshProductWithNameState> emit) async {
    emit(SearshProductWithNameLoading());
    final failureOrProducts = await searshProductWithNameUseCase(event.name);
    failureOrProducts.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(SearshProductWithNameUnauthorized());
        } else {
          emit(SearshProductWithNameError(
              message: mapFailureToMessage(failure)));
        }
      },
      (products) => emit(
        SearshProductWithNameLoaded(products: products),
      ),
    );
  }
}
