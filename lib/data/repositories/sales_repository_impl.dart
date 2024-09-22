import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/sales_remote_data_source.dart';
import 'package:indar_deco/data/models/sales_model.dart';
import 'package:indar_deco/domain/entities/sales.dart';
import 'package:indar_deco/domain/repositories/sales_repository.dart';

import '../../core/errors/exceptions/exceptions.dart';

class SalesRepositoryImpl implements SalesRepository{
    final SalesRemoteDataSource salesRemoteDataSource;

  SalesRepositoryImpl(this.salesRemoteDataSource);

  @override
  Future<Either<Failure, Sales>> addSale(Sales newSale) async{
     try {
      final SalesModel sale = SalesModel(modelId: newSale.modelId, productId: newSale.productId, providerId: newSale.providerId, userId: newSale.userId, quantity: newSale.quantity, status: newSale.status, totalPrice: newSale.totalPrice);
      final res = await salesRemoteDataSource.addSale(sale);
      return Right(res);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Sales>>> getAllSales(String userId) async{
          try {
      final salesModels = await salesRemoteDataSource.getAllSales(userId);
      return right(salesModels);
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Sales>> getSingleSale(String saleId) async{
           try {
      final salesModels = await salesRemoteDataSource.getSingleSales(saleId);
      return right(salesModels);
    } on ServerException {
      return left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Unit>> deleteSale(String saleId) async{
              try {
      await salesRemoteDataSource.deleteSales(saleId);
      return right(unit);
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSale(Sales sale) async{
        try {
      SalesModel salesModel=SalesModel(id: sale.id, modelId: sale.modelId,  productId: sale.productId, providerId: sale.providerId, userId: sale.userId, quantity: sale.quantity, status: sale.status, totalPrice: sale.totalPrice);
      await salesRemoteDataSource.updateSale(salesModel);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}