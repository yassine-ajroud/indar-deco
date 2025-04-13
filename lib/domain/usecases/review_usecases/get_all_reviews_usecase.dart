import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/repositories/review_repository.dart';

import '../../../core/errors/failures/failures.dart';
import '../../entities/review.dart';

class GetAllReviewsUsecase {
  final ReviewRepository _repository;

  const GetAllReviewsUsecase(this._repository);

   Future<Either<Failure, List<Review>>> call(String prodId) async=>
      await _repository.getAllReviews(prodId);
}
