import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
import '../../repositories/authentication_repository.dart';


class UpdateUserWishlistUsecase {
  final AuthenticationRepository repository;

  const UpdateUserWishlistUsecase(this.repository);
  Future<Either<Failure, Unit>> call({required wishlist,required id}) async => await repository.updateUserWishlist(wishlist: wishlist,id:id);
}
