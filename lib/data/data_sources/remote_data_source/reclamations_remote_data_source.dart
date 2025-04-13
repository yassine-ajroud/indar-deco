import 'package:dio/dio.dart';
import 'package:indar_deco/core/utils/api_const.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/settings_local_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:indar_deco/data/models/reclamation_model.dart';
import 'package:indar_deco/data/models/token_model.dart';
import 'package:indar_deco/domain/entities/reclamation.dart';
import '../../../core/errors/exceptions/exceptions.dart';

abstract class ReclamtionsRemoteDataSource{
  Future<List<Reclamation>> getAllReclamations(String userId);
  Future<Reclamation> getSingleReclamations(String reclamationId);
  Future<void> addNewReclamations(ReclamationModel newReclamation);

}

class ReclamationRemoteDataSourceImpl implements ReclamtionsRemoteDataSource{

Future<TokenModel>get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }
     Future<String>get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

    Future<void> verifyToken () async {
     return await token.then((value) async{
      if(value.expiryDate.isBefore(DateTime.now())){
        final newToken =await AuthenticationRemoteDataSourceImpl().refreshToken(value.refreshToken,value.userId);
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
  Future<List<Reclamation>> getAllReclamations(String userId) async{
    try {
            await verifyToken();
      final response = await dio.get('${ApiConst.reclamations}/all/$userId',
      options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      List<dynamic> data =response.data;
      List<ReclamationModel> sales =
          data.map((e) => ReclamationModel.fromJson(e)).toList();
      return sales;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Reclamation> getSingleReclamations(String reclamationId) async{
     try {
      await verifyToken();
      final response = await dio.get('${ApiConst.reclamations}/$reclamationId',
      options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      final data = response.data;
      return ReclamationModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }
  
  @override
  Future<void> addNewReclamations(ReclamationModel newReclamation) async{
      try {
      await dio.post(ApiConst.reclamations, data: newReclamation.toJson(),
      options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
    } catch (e) {
      throw ServerException();
    }
  }
}