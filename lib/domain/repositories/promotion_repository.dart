import 'package:dartz/dartz.dart';

import '../../core/errors/failures/failures.dart';
import '../entities/promotion.dart';

abstract class PromotionRepository {
  Future<Either<Failure, List<Promotion>>> getAllPromotions();
}
