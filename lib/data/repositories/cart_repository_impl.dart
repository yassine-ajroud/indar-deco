import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import '../../core/errors/exceptions/exceptions.dart';
import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_sources/remote_data_source/cart_remote_data_source.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
    final CartRemoteDataSource cartRemoteDataSource;

  CartRepositoryImpl(this.cartRemoteDataSource);


  @override
  Future<Either<Failure, Unit>> createCart({required String userId}) async{
    try {
      await cartRemoteDataSource.createCart(userId: userId);
      return right(unit);
    } on ServerException {
      return left(ServerFailure());
    
    }}
    
  @override
  Future<Either<Failure, Cart>> getCart({required String userId}) async{
  try {
      final result = await cartRemoteDataSource.getCart(userId: userId);
      return right(result);
    } on ServerException catch(e){
      return left(ServerFailure(message:e.message));
    } on DataNotFoundException catch (e){
       return left(DataNotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCart({required Cart cart}) async{
   try {
      CartModel cModel = CartModel(
          id: cart.id,
          userId: cart.userId,
          productsId: cart.productsId);
      await cartRemoteDataSource.updateCart(cart: cModel);
      return right(unit);
    } on ServerException catch(e) {
      return left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCart({required String cartID}) async{
      try {
      await cartRemoteDataSource.deleteCart(cartId: cartID);
      return right(unit);
    } on ServerException catch(e) {
      return left(ServerFailure(message:e.message));
    }
  }
}
