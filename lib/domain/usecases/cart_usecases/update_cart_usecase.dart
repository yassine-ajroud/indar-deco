import 'package:dartz/dartz.dart';


import '../../../core/errors/failures/failures.dart';
import '../../entities/cart.dart';
import '../../repositories/cart_repository.dart';

class UpdateCartUsecase {
  final CartRepository _repository;

   UpdateCartUsecase(this._repository);

  Future<Either<Failure, Unit>> call( {required Cart cart}) async =>
      await _repository.updateCart(cart:cart);
}
