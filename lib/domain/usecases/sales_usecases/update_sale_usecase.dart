import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/repositories/sales_repository.dart';

import '../../../core/errors/failures/failures.dart';
import '../../entities/sales.dart';

class UpdateSaleUsecase{
  final SalesRepository repository;

  const UpdateSaleUsecase(this.repository);

  Future<Either<Failure,Unit>> call(Sales newSale)async=>await repository.updateSale(newSale);
}