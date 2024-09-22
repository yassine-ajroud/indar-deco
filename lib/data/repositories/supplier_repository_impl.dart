import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/supplier_remote_data_source.dart';
import 'package:indar_deco/domain/entities/supplier.dart';
import 'package:indar_deco/domain/repositories/supplier_repository.dart';

import '../../core/errors/exceptions/exceptions.dart';

class SupplierRepositoryImpl implements SupplierRepository {
  SupplierRemoteDataSource supplierRemoteDataSource;
  SupplierRepositoryImpl(
     this.supplierRemoteDataSource,
  );


  @override
  Future<Either<Failure, Supplier>> getSupplierById({required String supplierId})async {
        try {
      final supplier =
          await supplierRemoteDataSource.getSupplierById(supplierId);
      return right(supplier);
  } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }
  
  @override
  Future<Either<Failure, List<Supplier>>> getSuppliers()async {
        try {
      final suppliers =
          await supplierRemoteDataSource.getSuppliers();
      return right(suppliers);
  } on ServerException {
      return left(ServerFailure());
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }
}
