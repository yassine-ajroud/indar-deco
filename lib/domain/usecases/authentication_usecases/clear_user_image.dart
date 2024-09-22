import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';

class ClearUserImageUsecase {
  final AuthenticationRepository repository;

  ClearUserImageUsecase(this.repository);
  Future<Either<Failure, Unit>> call(String userId) async =>
      await repository.clearUserImage(userId);
}
