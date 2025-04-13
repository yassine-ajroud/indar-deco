import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';


class GoogleLoginUsecase {
  final AuthenticationRepository repository;

  const GoogleLoginUsecase(this.repository);
  Future<Either<Failure, Map<String,dynamic>>> call() async => await repository.googleLogin();
}
