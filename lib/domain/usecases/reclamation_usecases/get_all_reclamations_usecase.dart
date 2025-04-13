import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/reclamation.dart';
import 'package:indar_deco/domain/repositories/reclamation_repository.dart';

class GetAllReclamationsUsecase {
  final ReclamationRepository _repository;

 const GetAllReclamationsUsecase(this._repository);

  Future<Either<Failure, List<Reclamation>>> call(String userID) async =>
      await _repository.getAllReclamations(userID);
}
