import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';

class CreateAccountUsecase {
  final AuthenticationRepository repository;

  CreateAccountUsecase(this.repository);
  Future<Either<Failure, String>> call({required address,required email,required firstName,required lastName,required password,required phone,required image,oauth,required String? gender,required String? birthdate,required String? recoveryEmail}) async =>
      await repository.createAccount(recoveryEmail: recoveryEmail, email: email,address: address,firstName: firstName,lastName: lastName,password: password,phone: phone,image: image,oauth: oauth,birthDate: birthdate,gender: gender);
}
