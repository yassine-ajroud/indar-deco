import 'package:dartz/dartz.dart';

import '../../core/errors/failures/failures.dart';
import '../entities/cart.dart';

abstract class CartRepository {

  Future<Either<Failure, Unit>> createCart({required String userId});
  Future<Either<Failure, Unit>> updateCart({required Cart cart});
  Future<Either<Failure, Cart>> getCart({required String userId});
  Future<Either<Failure, Unit>> deleteCart({required String cartID});

}
