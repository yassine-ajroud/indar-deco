import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../entities/user.dart';
import '../../repositories/authentication_repository.dart';

class GetUserUsecase {
  final AuthenticationRepository repository;
  const GetUserUsecase(this.repository);
  Future<Either<Failure, User>> call(String id) async =>
      await repository.getUser(id);
}
