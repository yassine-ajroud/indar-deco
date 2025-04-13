import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/rating.dart';
import 'package:indar_deco/domain/repositories/rating_repository.dart';

class GetSingleRatingUsecase {
  final RatingRepository _repository;

  GetSingleRatingUsecase(this._repository);

  Future<Either<Failure, SimpleRating>> call(String ratingID) async => await _repository.getSingleRating(ratingID);
}
