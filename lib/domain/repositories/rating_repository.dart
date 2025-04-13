import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/entities/rating.dart';

import '../../core/errors/failures/failures.dart';

abstract class RatingRepository {
   Future<Either<Failure, SimpleRating>> addRating(SimpleRating rating);
  Future<Either<Failure,ProductRating>> getRatings(String productID);
  Future<Either<Failure, SimpleRating>> getSingleRating(String ratingID);
  Future<Either<Failure, SimpleRating>> updateRating(SimpleRating newRating);
  Future<Either<Failure, Unit>> deleteRating(String ratingID);
}