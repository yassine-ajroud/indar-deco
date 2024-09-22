import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';


class UpdatePasswordUsecase {
  final AuthenticationRepository repository;

  const UpdatePasswordUsecase(this.repository);
  Future<Either<Failure, Unit>> call({required String userId,required String oldPassword,required String newPassword, required String recoverEmail}) async => await repository.updatePassword(userId: userId,oldPassword: oldPassword,newPassword:newPassword,recoverEmail: recoverEmail);
}
