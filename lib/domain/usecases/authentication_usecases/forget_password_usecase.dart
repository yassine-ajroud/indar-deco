import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';


class ForgetPasswordUsecase {
  final AuthenticationRepository repository;

  const ForgetPasswordUsecase(this.repository);
  Future<Either<Failure, Unit>> call({required String email,required String destination}) async => await repository.forgetPassword(email:email,destination:destination);
}
