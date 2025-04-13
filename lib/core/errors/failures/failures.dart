// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  String? message;
  int? statusCode;
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  final String? message;

  ServerFailure({this.message});
}

class ConnectionFailure extends Failure {}
class DataNotFoundFailure extends Failure {
    @override
  final String? message;

  DataNotFoundFailure(this.message);
}
class BadOTPFailure extends Failure {
      @override
  final String? message;

  BadOTPFailure(this.message);
}


class RegistrationFailure extends Failure {
    @override
  final String? message;

  RegistrationFailure(this.message);
}

class LoginFailure extends Failure {
  @override
  final String? message;

  LoginFailure(this.message);
}

class ProductNotFoundFailure extends Failure {}

class LocalStorageFailure extends Failure {}

class NotAuthorizedFailure extends Failure {}


