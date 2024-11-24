import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../core/errors/failures/failures.dart';
import '../entities/token.dart';
import '../entities/user.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure,String>> createAccount({required String? address,required String? email,required firstName,required lastName,required password,required String? phone,required String image,required String? oauth,required String? birthDate, required String? gender, required String? recoveryEmail});
  Future<Either<Failure,Token>> login({required String email,required String password});
  Future<Either<Failure,Token>> autologin();
  Future<Either<Failure,Unit>> updateProfil({required address,required email,required firstName,required lastName,required phone,required id,required birthDate,required gender});
  Future<Either<Failure,Unit>> logout();
  Future<Either<Failure,Unit>> clearUserImage(String userId);
  Future<Either<Failure,Map<String,dynamic>>> facebookLogin();
  Future<Either<Failure,Map<String,dynamic>>> googleLogin();
  Future<Either<Failure,Unit>> resetPassword({required String email,required String password});
  Future<Either<Failure,Unit>> forgetPassword({required String email,required String destination});
  Future<Either<Failure,Unit>> verifyOTP({required String email,required int otp});
  Future<Either<Failure,User>> getUser(String id);
  Future<Either<Failure,Unit>> updatePassword({required String userId,required String oldPassword,required String newPassword,required String recoverEmail});
  Future<Either<Failure,Unit>> updateUserImage({required String userId,required File file});
  Future<Either<Failure,String?>> getRecoveryEmail({required String email});

}
