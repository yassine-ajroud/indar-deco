import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/exceptions/exceptions.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/rating_remote_data_source.dart';
import 'package:indar_deco/data/models/rating_model.dart';
import 'package:indar_deco/domain/entities/rating.dart';
import 'package:indar_deco/domain/repositories/rating_repository.dart';

class RatingRepositoryImpl implements RatingRepository {
  final RatingRemoteDataSource ratingRemoteDataSource;

  RatingRepositoryImpl(this.ratingRemoteDataSource);

  @override
  Future<Either<Failure, SimpleRating>> addRating(SimpleRating rating) async {
    try {
      final SimpleRatingModel rm = SimpleRatingModel(
          id: rating.id,
          user: rating.user,
          product: rating.product,
          rate: rating.rate);
      final res = await ratingRemoteDataSource.addRating(rm);
      return right(res);
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteRating(String ratingID) async {
    try {
      await ratingRemoteDataSource.deleteRating(ratingID);
      return right(unit);
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProductRating>> getRatings(String productID) async {
    try {
      final ratingModels = await ratingRemoteDataSource.getRatings(productID);
      return right(ratingModels);
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SimpleRating>> getSingleRating(String ratingID) async {
    try {
      final ratingModel =
          await ratingRemoteDataSource.getSingleRating(ratingID);
      return right(ratingModel);
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SimpleRating>> updateRating(SimpleRating newRating) async {
    try {
      final SimpleRatingModel newRM = SimpleRatingModel(
          id: newRating.id,
          user: newRating.user,
          product: newRating.product,
          rate: newRating.rate);
      final ratingModel = await ratingRemoteDataSource.updateRating(newRM);
      return right(ratingModel);
    } on ServerException {
      return left(ServerFailure());
    }
  }

}
