import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../repositories/cart_repository.dart';

class CreateCartUsecase {
  final CartRepository _repository;

  CreateCartUsecase(this._repository);

  Future<Either<Failure, Unit>> call({required String userId}) async =>
      await _repository.createCart(userId: userId);
}
