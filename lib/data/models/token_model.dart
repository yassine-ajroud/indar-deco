import '../../domain/entities/token.dart';

class TokenModel extends Token {
  const TokenModel({required super.token, required super.refreshToken,required super.expiryDate, required super.userId});

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      TokenModel(token: json['token'], refreshToken: json['refreshtoken'],expiryDate: DateTime.parse(json['tokenExpiration'].toString()) ,userId: json['Uid']);

  Map<String, dynamic> toJson() =>
      {'token': token, 'refreshtoken': refreshToken,'Uid':userId,'tokenExpiration':expiryDate.toString()};


}
