import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/rating.dart';
import 'package:indar_deco/domain/repositories/rating_repository.dart';

class AddRatingUsecase {
  final RatingRepository _repository;

  AddRatingUsecase(this._repository);

  Future<Either<Failure, SimpleRating>> call(SimpleRating rating) async => await _repository.addRating(rating);
}
