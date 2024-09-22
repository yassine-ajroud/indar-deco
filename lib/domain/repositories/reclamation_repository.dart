import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/reclamation.dart';

abstract class ReclamationRepository {
  Future<Either<Failure, List<Reclamation>>> getAllReclamations(String userID);
  Future<Either<Failure, Reclamation>> getSingleReclamation(String reclamationID);
  Future<Either<Failure, Unit>> addReclamation(Reclamation newReclamation);
}
