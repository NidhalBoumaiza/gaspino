import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/entities/product.dart';
import '../../../domain layer/usecases/delete_my_product.dart';

part 'delete_my_product_state.dart';

class DeleteMyProductCubit extends Cubit<DeleteMyProductState> {
  final DeleteMyProductUseCase deleteMyProductUseCase;

  DeleteMyProductCubit({required this.deleteMyProductUseCase})
      : super(DeleteMyProductInitial());

  Future<void> deleteMyProduct(String productId, List<Product> products) async {
    emit(DeleteMyProductLoading());
    final failureOrSuccess = await deleteMyProductUseCase(productId);
    failureOrSuccess.fold(
      (failure) {
        if (failure is UnauthorizedFailure) {
          emit(DeleteMyProductUnauthorized());
        } else {
          emit(DeleteMyProductError(mapFailureToMessage(failure)));
        }
      },
      (_) {
        products.removeWhere((product) => product.id == productId);
        emit(DeleteMyProductSuccess(products));
      },
    );
  }
}
