
class ServerException implements Exception {
    final String? message;
  ServerException({
     this.message,
  });

}

class ConnectionException implements Exception {}

class RegistrationException implements Exception {
    final String? message;
  RegistrationException(this.message);
}

class LoginException implements Exception {
  final String? message;
  LoginException(this.message);}

class ProductNotFoundException implements Exception {}
class RefreshTokenException implements Exception {}
class BadOTPException implements Exception {
     final String? message;
  BadOTPException(this.message);
}

class NotAuthorizedException implements Exception {}
class DataNotFoundException implements Exception {
   final String? message;
  DataNotFoundException(this.message);
}

class LocalStorageException implements Exception {}
