import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/reclamation.dart';
import 'package:indar_deco/domain/repositories/reclamation_repository.dart';

class GetSingleReclamationUsecase {
  final ReclamationRepository _repository;

  const GetSingleReclamationUsecase(this._repository);

  Future<Either<Failure,Reclamation>> call(String reclamationID) async =>
      await _repository.getSingleReclamation(reclamationID);
}
