import 'package:dartz/dartz.dart';

import '../../core/errors/failures/failures.dart';
import '../entities/wishlist.dart';

abstract class WishListRepository {
  Future<Either<Failure, Unit>> createWishlist({required String userId});
  Future<Either<Failure, Unit>> updateWishlist({required WishList wishlist});
  Future<Either<Failure,WishList>> getWishlist({required String userId});
  Future<Either<Failure, Unit>> deleteWishlist({required String wishlistID});

}
