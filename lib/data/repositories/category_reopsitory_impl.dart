import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/exceptions/exceptions.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../data_sources/remote_data_source/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  const CategoryRepositoryImpl(this.categoryRemoteDataSource);

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final categoryModels = await categoryRemoteDataSource.getAllCategories();
      final category = categoryModels
          .map((e) => Category(
               title: e.title,
               id: e.id,
               image: e.image
              ))
          .toList();
      return right(category);
    } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }  
}
