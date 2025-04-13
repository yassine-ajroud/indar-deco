import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';


class UpdateProfilUsecase {
  final AuthenticationRepository repository;

  const UpdateProfilUsecase(this.repository);
  Future<Either<Failure, Unit>> call({required address,required email,required firstName,required lastName,required phone,required id,required birthDate,required gender}) async => await repository.updateProfil(address: address,email: email,firstName: firstName,lastName: lastName,phone: phone,id:id,birthDate: birthDate,gender: gender);
}
