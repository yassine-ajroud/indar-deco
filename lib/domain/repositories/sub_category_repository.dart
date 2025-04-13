import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/sub_catergory.dart';

abstract class SubCategoryRepository {
  Future<Either<Failure, List<SubCategory>>> getAllSubCategories();
}
