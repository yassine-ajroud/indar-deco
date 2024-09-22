import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/reclamations_remote_data_source.dart';
import 'package:indar_deco/data/models/reclamation_model.dart';
import 'package:indar_deco/domain/entities/reclamation.dart';
import 'package:indar_deco/domain/repositories/reclamation_repository.dart';

import '../../core/errors/exceptions/exceptions.dart';

class ReclamationsRepositoryImpl implements ReclamationRepository{
    final ReclamtionsRemoteDataSource reclamationRemoteDataSource;

  ReclamationsRepositoryImpl(this.reclamationRemoteDataSource);

  @override
  Future<Either<Failure, Unit>> addReclamation(Reclamation newReclamation) async{
       try {
      final ReclamationModel reclamation = ReclamationModel(address: newReclamation.address, date: newReclamation.date, user: newReclamation.user, sales: newReclamation.sales, reference: newReclamation.reference, price: newReclamation.price, verified: newReclamation.verified,completed: newReclamation.completed); 
      await reclamationRemoteDataSource.addNewReclamations(reclamation);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Reclamation>>> getAllReclamations(String userID) async{
        try {
      final reclamationModels = await reclamationRemoteDataSource.getAllReclamations(userID);
      return right(reclamationModels);
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Reclamation>> getSingleReclamation(String reclamationID) async{
              try {
      final reclamation = await reclamationRemoteDataSource.getSingleReclamations(reclamationID);
      return right(reclamation);
    } on ServerException {
      return left(ServerFailure());
    }
  }

}