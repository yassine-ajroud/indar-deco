import 'package:dartz/dartz.dart';
import 'package:indar_deco/domain/repositories/authentication_repository.dart';

import '../../../core/errors/failures/failures.dart';
import '../../entities/token.dart';


class AutoLoginUsecase {
  final AuthenticationRepository repository;

  const AutoLoginUsecase(this.repository);
  Future<Either<Failure, Token>> call() async => await repository.autologin();
}
