import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/exceptions/exceptions.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/product_3d_remote_data_source.dart';
import 'package:indar_deco/domain/entities/product3D.dart';
import 'package:indar_deco/domain/repositories/product3d_repository.dart';


class Product3DRepositoryImpl implements Product3DRepository{
  final Product3DRemoteDataSource product3dRemoteDataSource;

  Product3DRepositoryImpl(this.product3dRemoteDataSource);
  @override
  Future<Either<Failure, List<Product3D>>> getAll3DProducts(String product) async{
     try {
      final product3DModels = await product3dRemoteDataSource.getAll3DProducts(product);
      final products3D = product3DModels
          .map((e) => Product3D(model3D: e.model3D, texture: e.texture, quantity: e.quantity, id: e.id, product: e.product))
          .toList();
      return right(products3D);
    } on ServerException {
      return left(ServerFailure());
    } 
  }

  @override
  Future<Either<Failure, Product3D>> getOne3DProduct(String product3DId) async {
       try {
      final product3DModels = await product3dRemoteDataSource.getone3DProducts(product3DId);
      final products3D = Product3D(model3D: product3DModels.model3D, texture: product3DModels.texture, quantity: product3DModels.quantity, id: product3DModels.id, product: product3DModels.product);
      return right(products3D);
    } on ServerException {
      return left(ServerFailure());
    } 
  }

}