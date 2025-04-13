import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';


class FacebookLoginUsecase {
  final AuthenticationRepository repository;

  const FacebookLoginUsecase(this.repository);
  Future<Either<Failure, Map<String,dynamic>>> call() async => await repository.facebookLogin();
}
