import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/repositories/sales_repository.dart';

import '../../../core/errors/failures/failures.dart';

class DeleteSaleUsecase{
  final SalesRepository repository;

  DeleteSaleUsecase(this.repository);

  Future<Either<Failure,Unit>> call(String saleId)async=>await repository.deleteSale(saleId);
}