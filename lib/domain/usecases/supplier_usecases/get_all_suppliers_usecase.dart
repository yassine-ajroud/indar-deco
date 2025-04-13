import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/entities/supplier.dart';
import 'package:indar_deco/domain/repositories/supplier_repository.dart';

import '../../../core/errors/failures/failures.dart';

class GetSuppliersUsecase {
  final SupplierRepository repository;

  GetSuppliersUsecase(this.repository);

  Future<Either<Failure, List<Supplier>>> call() async =>
      await repository.getSuppliers();
}
