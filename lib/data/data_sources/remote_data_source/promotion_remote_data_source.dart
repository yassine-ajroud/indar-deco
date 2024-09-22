import 'package:dio/dio.dart';
import 'package:indar_deco/core/utils/api_const.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/settings_local_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:indar_deco/data/models/promotion_model.dart';
import 'package:indar_deco/data/models/token_model.dart';

import '../../../core/errors/exceptions/exceptions.dart';

abstract class PromotionRemoteDataSource {
  Future<List<PromotionModel>> getAllPromotions();
}

class PromotionRemoteDataSourceImpl implements PromotionRemoteDataSource{
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
  Future<List<PromotionModel>> getAllPromotions() async{
    try {
      await verifyToken();
      final response = await dio.get(
        ApiConst.promotions,
         options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),
      );
      List<dynamic> data = response.data;
      List<PromotionModel> promotions =
          data.map((e) => PromotionModel.fromJson(e)).toList();
      return promotions;
    } catch (e) {
        throw ServerException();
      
    }
  }

}