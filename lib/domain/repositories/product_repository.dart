import 'package:dartz/dartz.dart';

import '../../core/errors/failures/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure,Product>> getProductById({required String productId});
  Future<Either<Failure,List<Product>>> getAllProducts();
  Future<Either<Failure,List<Product>>> getSortedProducts();
  Future<Either<Failure,List<Product>>> getProductsByCategory({required String category});
  Future<Either<Failure,List<Product>>> getProductsBySubCategory({required String category,required String subCategory});
}
