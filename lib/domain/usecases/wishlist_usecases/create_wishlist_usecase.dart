import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../repositories/wishlist_repository.dart';

class CreateWishListUsecase {
  final WishListRepository _repository;

  CreateWishListUsecase(this._repository);

  Future<Either<Failure, Unit>> call({required String userId}) async =>
      await _repository.createWishlist(userId: userId);
}
