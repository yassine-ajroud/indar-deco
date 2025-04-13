import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';


class UpdateUserCartUsecase {
  final AuthenticationRepository repository;

  const UpdateUserCartUsecase(this.repository);
  Future<Either<Failure, Unit>> call({required cart,required id}) async => await repository.updateUserCart(cart: cart,id:id);
}
