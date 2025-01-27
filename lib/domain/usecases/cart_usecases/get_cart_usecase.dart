import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../entities/cart.dart';
import '../../repositories/cart_repository.dart';

class GetCartUsecase {
  final CartRepository _repository;

   GetCartUsecase(this._repository);

  Future<Either<Failure, Cart>> call({required String userId}) async =>
      await _repository.getCart(userId:userId);
}

