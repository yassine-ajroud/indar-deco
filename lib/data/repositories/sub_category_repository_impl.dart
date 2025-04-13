import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/exceptions/exceptions.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/sub_category_remote_data_source.dart';
import 'package:indar_deco/domain/entities/sub_catergory.dart';
import 'package:indar_deco/domain/repositories/sub_category_repository.dart';

class SubCategoryRepositoryImpl implements SubCategoryRepository {
  final SubCategoryRemoteDataSource subCategoryRemoteDataSource;

  const SubCategoryRepositoryImpl(this.subCategoryRemoteDataSource);

  @override
  Future<Either<Failure, List<SubCategory>>> getAllSubCategories() async {
    try {
      final subCategoryModels = await subCategoryRemoteDataSource.getAllSubCategories();
      final subcategories = subCategoryModels
          .map((e) => SubCategory(
               title: e.title,
               id: e.id,
               image: e.image
              ))
          .toList();
      return right(subcategories);
    } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }  
}
