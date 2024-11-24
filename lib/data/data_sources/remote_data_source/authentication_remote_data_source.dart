

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http_parser/http_parser.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/settings_local_data_source.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../core/utils/api_const.dart';
import '../../../domain/entities/user.dart';
import '../../models/token_model.dart';
import '../../models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


abstract class AuthenticationRemoteDataSource {
  Future<String> createAccount({required String? address,required email,required firstName,required lastName,required password,required phone,required String? image,required String? oauth,required String? gender, required String? birthDate});
  Future<TokenModel> login(String email, String password);
  Future<Map<String,dynamic>> googleLogin();
  Future<Map<String,dynamic>> facebookLogin();
  Future<User> getcurrentUser(String id);
  Future<void> updateProfil({required String address,required String email,required String firstName,required String lastName,required String phone,required String id,required String birthdate,required String gender});
  Future<void> forgetPassword({required String email,required String destination});
  Future<void> verifyOTP(String email,int otp);
  Future<void> resetPassword(String email,String password);
  Future<void> updatePassword(String userID,String oldPassword,String newPassword,String recoverEmail);
  Future<TokenModel> refreshToken(String refreshToken,String uid);
  Future<TokenModel> autoLogin();
  Future<void> clearUserImage(String userId);
  Future<void> updateUserImage(String userID,File file);
  Future<String?> getRecoveryEmail(String email);


}




class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {

    Future<TokenModel>get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }
   Future<String>get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

    Future<void> verifyToken () async {
     return await token.then((value) async{
      if(value.expiryDate.isBefore(DateTime.now())){
        final newToken =await refreshToken(value.refreshToken,value.userId);
        await AuthenticationLocalDataSourceImpl().saveUserInformations(newToken);
      }
    });
  }
  final dio = Dio(BaseOptions(
  baseUrl: ApiConst.baseUrl,
  contentType: Headers.jsonContentType,
  validateStatus: (int? status) {
    return status != null;
    // return status != null && status >= 200 && status < 300;
  },
));

  @override
  Future<String> createAccount({required String? address,required email,required firstName,required lastName,required password,required phone,required String? image,required String? oauth,required String? gender, required String? birthDate}) async {
    try {
    AppLocalizations t = await AppLocalizations.delegate.load(Locale(await locale));
      UserModel userModel = UserModel(
          oAuth: oauth,
          gender: gender,
          recoveryEmail: null,
          birthDate: birthDate,
          firstName: firstName,
          lastName: lastName,
          address: address,
          email: email,
          phone: phone,
          password: password,
          ban: false,
          image:image??'');
      final res = await dio.post(ApiConst.register, data: userModel.toJson());
   if(res.statusCode==201){
      return res.data["uId"];
     }else if(res.statusCode==403){
                throw RegistrationException(t.email_already_used);
     }
     else{
              throw ServerException(message :"error");
     }
    } catch (e) {
      rethrow; 
    } 
  }

  @override
  Future<TokenModel> login(String email, String password) async {
    String msg="";
    AppLocalizations t = await AppLocalizations.delegate.load(Locale(await locale));
    try {
      Map<String, dynamic> user = {'email': email, 'password': password};
      final response = await dio.post(ApiConst.login, data: user);
      if(response.statusCode==200){
      final data = response.data;
      final TokenModel token = TokenModel.fromJson(data);
      return token;
       }else {
        switch (response.statusCode) {
          case 202:msg=t.wrong_password;
            break;
          case 404:msg=t.email_not_registred;
            break;
          default:
        }
        throw LoginException(msg);}
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

//not completed
  @override
  Future<Map<String,dynamic>> googleLogin() async {
    try {
      final googleSignIN = GoogleSignIn();
      final user = await googleSignIN.signIn();
      if (user != null) {
        final name = user.displayName!.split(' ');
        final email = user.email;
         final res = {
          'id': user.id,
          'firstName':name[0],
          'lastName':name[1],
          'email':email,
          'image':user.photoUrl
         };
        googleSignIN.signOut;
        await googleSignIN.disconnect();
        return res;
      } else {
        throw LoginException("Login failure");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getcurrentUser(String id) async {
    try {
      await verifyToken();
      final response = await dio.get(ApiConst.getProfile, data: {"id": id}, options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      return UserModel.fromJson(response.data['user']);
    } catch (e) {
      throw DataNotFoundException('');
    }
  }

  @override
  Future<void> updateProfil({required address,required email,required firstName,required lastName,required phone,required id,required gender,required birthdate}) async {
    try {
      await verifyToken();
      Map<String,dynamic> model = {
          'id':id,
          'firstName': firstName,
          'lastName': lastName,
          'address': address,
          'email': email,
          'phone': phone,
          'gender':gender,
          'birthDate':birthdate
          };
      await dio.put(ApiConst.updateProfil, data: model,options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
    } catch (e) {
      throw ServerException(message: 'cannot update profile');
    }
  }

  @override
  Future<Map<String,dynamic>> facebookLogin() async {
    try {
             FacebookAuth.instance.logOut();
      final  result = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile',]);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData(fields: "name,email,picture.width(200)");
        return userData;
      } else {
        throw LoginException("Login failure");
      }
    } on LocalStorageException {
      rethrow;
    }
  }
  
  @override
  Future<void> forgetPassword({required String email,required String destination}) async{
     try {
    AppLocalizations t = await AppLocalizations.delegate.load(Locale(await locale));
     final res = await dio.post(ApiConst.forgetPassword, data: {"email":email,"destination":destination});
     if(res.statusCode==404){
      throw DataNotFoundException(t.email_not_registred);
     }else if(res.statusCode==500){
              throw ServerException(message:"server error");

     }
    } catch (e) {
      rethrow;
    } 
  }
  
  @override
  Future<TokenModel> refreshToken(String refreshToken,String uid)async {
     try {
      final res = await dio.post(ApiConst.refreshToken, data: {"refreshtoken":refreshToken,"uid":uid},);
      if(res.statusCode==400){
      throw NotAuthorizedException();
     }
      return TokenModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    } 
  }
  
  @override
  Future<void> resetPassword(String email, String password) async{
      try {
    AppLocalizations t = await AppLocalizations.delegate.load(Locale(await locale));
      final res =await dio.post(ApiConst.resetPassword, data: {"email":email,"password":password});
    if(res.statusCode==404){
      throw DataNotFoundException(t.email_not_registred);
     }else if(res.statusCode==500){
              throw ServerException(message :"error");
     }
    } catch (e) {
      rethrow; 
    } 
  }
  
  @override
  Future<void> updatePassword(String userID, String oldPassword, String newPassword,String recoverEmail)async {
      try {
            AppLocalizations t = await AppLocalizations.delegate.load(Locale(await locale));

      await verifyToken();
      final res =await dio.post(ApiConst.updatePassword, data: {"id":userID,"oldPassword":oldPassword,"newPassword":newPassword,"newRecovery":recoverEmail}, options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
         if(res.statusCode==202){
      throw DataNotFoundException(t.wrong_password);
     }else if(res.statusCode==500){
              throw ServerException(message:"server error");


     }
    } catch (e) {
      rethrow;
    } 
  }
  
  @override
  Future<void> verifyOTP(String email, int otp) async{
      try {
    AppLocalizations t = await AppLocalizations.delegate.load(Locale(await locale));
      final res =await dio.post(ApiConst.verifyOTP, data: {"email":email,"otp":otp});
      if(res.statusCode==404){
      throw BadOTPException(t.code_invalid);
     }else if(res.statusCode==400){
              throw BadOTPException(t.expired_code);
     }
    } catch (e) {
      rethrow; 
    } 
  }
  
  @override
  Future<TokenModel> autoLogin() async{
     try {
      await verifyToken();
      return token;
    } catch (e) {
      print(e);
     rethrow;
    } 
  }
  
  @override
  Future<void> clearUserImage(String userId) async{
    
     try {
      await verifyToken();
      Map<String,dynamic> model = {
          'id':userId,
          'imageUrl':''};
      await dio.put(ApiConst.updateProfil, data: model,options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
    } catch (e) {
      throw ServerException(message: 'cannot update profile');
    }
  }
  
  @override
  Future<void> updateUserImage(String userID, File file) async{
       try {
String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
        'id':userID,
        "file":
            await MultipartFile.fromFile(file.path, filename:fileName,contentType: MediaType("image","jpeg")),
    });

      await dio.post(ApiConst.updateUserImage, data: formData);
    } catch (e) {
      throw ServerException(message: 'cannot update image');
    }
  }
  
  @override
  Future<String?> getRecoveryEmail(String email) async{
         try {
      final res = await dio.get(ApiConst.userEmail, data: {"email":email},);
      return res.data['recoveryEmail'];
    } catch (e) {
      rethrow;
    } 
  }
}