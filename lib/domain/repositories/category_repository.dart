import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';

import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
}
