import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';


class UpdateUserImageUsecase {
  final AuthenticationRepository repository;

  const UpdateUserImageUsecase(this.repository);
  Future<Either<Failure, Unit>> call({required String userId,required File file}) async => await repository.updateUserImage(userId: userId,file: file);
}
