import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/wishlist_remote_data_source.dart';
import 'package:indar_deco/data/models/wishlist_model.dart';
import 'package:indar_deco/domain/entities/wishlist.dart';
import 'package:indar_deco/domain/repositories/wishlist_repository.dart';
import '../../core/errors/exceptions/exceptions.dart';


class WishListRepositoryImpl implements WishListRepository {
    final WishListRemoteDataSource wishlistRemoteDataSource;

  WishListRepositoryImpl(this.wishlistRemoteDataSource);


  @override
  Future<Either<Failure, Unit>> createWishlist({required String userId}) async{
    try {
      await wishlistRemoteDataSource.createWishlist(userId: userId);
      return right(unit);
    } on ServerException {
      return left(ServerFailure());
    
    }}
    
  @override
  Future<Either<Failure, WishList>> getWishlist({required String userId}) async{
  try {
      final result = await wishlistRemoteDataSource.getWishlist(userId: userId);
      return right(result);
    } on ServerException catch(e){
      return left(ServerFailure(message:e.message));
    } on DataNotFoundException catch (e){
       return left(DataNotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateWishlist({required WishList wishlist}) async{
   try {
      WishListModel wModel = WishListModel(
          id: wishlist.id,
          userId: wishlist.userId,
          productsId: wishlist.productsId);
      await wishlistRemoteDataSource.updateWishlist(wishlist: wModel);
      return right(unit);
    } on ServerException catch(e) {
      return left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteWishlist({required String wishlistID}) async{
      try {
      await wishlistRemoteDataSource.deleteWishlist(wishlistId: wishlistID);
      return right(unit);
    } on ServerException catch(e) {
      return left(ServerFailure(message:e.message));
    }
  }
}
