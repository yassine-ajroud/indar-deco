import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../repositories/wishlist_repository.dart';

class DeleteWishListUsecase {
  final WishListRepository _repository;

   DeleteWishListUsecase(this._repository);

  Future<Either<Failure, Unit>> call({required String wishlistId}) async =>
      await _repository.deleteWishlist(wishlistID:wishlistId);
}
