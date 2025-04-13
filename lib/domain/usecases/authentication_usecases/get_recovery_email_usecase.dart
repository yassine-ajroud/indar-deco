import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';


class GetRecoveryEmailUsecase {
  final AuthenticationRepository repository;

  const GetRecoveryEmailUsecase(this.repository);
  Future<Either<Failure, String?>> call({required String email}) async => await repository.getRecoveryEmail(email:email );
}
