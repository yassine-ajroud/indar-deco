import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/entities/supplier.dart';

import '../../core/errors/failures/failures.dart';

abstract class SupplierRepository {
  Future<Either<Failure,Supplier>> getSupplierById({required String supplierId});
  Future<Either<Failure,List<Supplier>>> getSuppliers();

}
