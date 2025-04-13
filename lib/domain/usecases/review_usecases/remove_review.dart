import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/repositories/review_repository.dart';

import '../../../core/errors/failures/failures.dart';

class RemoveReviewUsecase {
  final ReviewRepository _repository;

  const RemoveReviewUsecase(this._repository);

  Future<Either<Failure, Unit>> call(String prodId) async=>
      await _repository.removeReview(prodId);
}
