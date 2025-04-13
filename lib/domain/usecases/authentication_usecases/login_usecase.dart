import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
import '../../entities/token.dart';
import '../../repositories/authentication_repository.dart';


class LoginUsecase {
  final AuthenticationRepository repository;

  const LoginUsecase(this.repository);
  Future<Either<Failure, Token>> call({required String email,required String password}) async => await repository.login(email: email,password: password);
}
