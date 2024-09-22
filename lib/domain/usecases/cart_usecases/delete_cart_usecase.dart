import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../repositories/cart_repository.dart';

class DeleteCartUsecase {
  final CartRepository _repository;

   DeleteCartUsecase(this._repository);

  Future<Either<Failure, Unit>> call({required String cartId}) async =>
      await _repository.deleteCart(cartID:cartId);
}
