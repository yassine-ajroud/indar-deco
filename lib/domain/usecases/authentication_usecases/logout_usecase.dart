import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';

class LogoutUsecase {
  final AuthenticationRepository repository;

  const LogoutUsecase(this.repository);
  Future<Either<Failure, Unit>> call() async => await repository.logout();
}
