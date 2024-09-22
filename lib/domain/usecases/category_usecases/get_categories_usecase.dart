import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/entities/category.dart';
import '../../../core/errors/failures/failures.dart';
import '../../repositories/category_repository.dart';

class GetAllCategoriesUsecase {
  final CategoryRepository repository;

  GetAllCategoriesUsecase(this.repository);

  Future<Either<Failure, List<Category>>> call() async =>
      await repository.getAllCategories();
}
