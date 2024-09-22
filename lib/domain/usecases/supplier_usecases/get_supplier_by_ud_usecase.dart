import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/entities/supplier.dart';
import 'package:indar_deco/domain/repositories/supplier_repository.dart';

import '../../../core/errors/failures/failures.dart';

class GetSupplierByIdUsecase {
  final SupplierRepository repository;

  GetSupplierByIdUsecase(this.repository);

  Future<Either<Failure, Supplier>> call(String supplierId) async =>
      await repository.getSupplierById(supplierId:supplierId);
}
