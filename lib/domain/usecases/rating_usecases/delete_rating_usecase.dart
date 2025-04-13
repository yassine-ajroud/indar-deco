import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/repositories/rating_repository.dart';

class DeleteRatingUsecase {
  final RatingRepository _repository;

  DeleteRatingUsecase(this._repository);

  Future<Either<Failure, Unit>> call(String ratingID) async => await _repository.deleteRating(ratingID);
}
