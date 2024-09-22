import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/repositories/sales_repository.dart';

import '../../../core/errors/failures/failures.dart';
import '../../entities/sales.dart';

class GetSingleSalesUsecase{
  final SalesRepository repository;

  GetSingleSalesUsecase(this.repository);

  Future<Either<Failure,Sales>> call(String saleId)async=>await repository.getSingleSale(saleId);
}