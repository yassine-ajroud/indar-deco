import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/repositories/sales_repository.dart';

import '../../../core/errors/failures/failures.dart';
import '../../entities/sales.dart';

class AddSaleUsecase{
  final SalesRepository repository;

  AddSaleUsecase(this.repository);

  Future<Either<Failure,Sales>> call(Sales newSale)async=>await repository.addSale(newSale);
}