import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/product3D.dart';
import 'package:indar_deco/domain/repositories/product3d_repository.dart';

class Get3DProductsByIdUseCase {
  final Product3DRepository _repository;

  const Get3DProductsByIdUseCase(this._repository);

  Future<Either<Failure, Product3D>> call(String productid) async =>
      await _repository.getOne3DProduct(productid);
}
