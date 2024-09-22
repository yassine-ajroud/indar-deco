import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';


class OTPVerificationUsecase {
  final AuthenticationRepository repository;

  const OTPVerificationUsecase(this.repository);
  Future<Either<Failure, Unit>> call({required String email,required int otp}) async => await repository.verifyOTP(email: email,otp: otp);
}
