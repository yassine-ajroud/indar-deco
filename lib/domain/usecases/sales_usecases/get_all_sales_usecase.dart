import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/repositories/sales_repository.dart';

import '../../../core/errors/failures/failures.dart';
import '../../entities/sales.dart';

class GetAllSalesUsecase{
  final SalesRepository repository;

  GetAllSalesUsecase(this.repository);

  Future<Either<Failure,List<Sales>>> call(String userId)async=>await repository.getAllSales(userId);
}