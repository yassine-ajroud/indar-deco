import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
import '../../entities/wishlist.dart';
import '../../repositories/wishlist_repository.dart';

class GetWishListUsecase {
  final WishListRepository _repository;

   GetWishListUsecase(this._repository);

  Future<Either<Failure, WishList>> call({required String userId}) async =>
      await _repository.getWishlist(userId:userId);
}
