import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';


class ResetPasswordUsecase {
  final AuthenticationRepository repository;

  const ResetPasswordUsecase(this.repository);
  Future<Either<Failure, Unit>> call({required String email,required String password}) async => await repository.resetPassword(email: email,password: password);
}
