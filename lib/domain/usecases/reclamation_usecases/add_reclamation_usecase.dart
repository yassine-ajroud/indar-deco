import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/reclamation.dart';
import 'package:indar_deco/domain/repositories/reclamation_repository.dart';

class AddReclamationsUsecase {
  final ReclamationRepository _repository;

 const AddReclamationsUsecase(this._repository);

  Future<Either<Failure, Unit>> call(Reclamation newReclamation) async =>
      await _repository.addReclamation(newReclamation);
}
