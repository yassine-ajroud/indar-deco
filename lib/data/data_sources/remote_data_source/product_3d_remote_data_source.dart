import 'package:dio/dio.dart';
import 'package:indar_deco/core/errors/exceptions/exceptions.dart';
import 'package:indar_deco/core/utils/api_const.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/settings_local_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:indar_deco/data/models/product3D_model.dart';
import 'package:indar_deco/data/models/token_model.dart';

abstract class Product3DRemoteDataSource{
  Future<List<Product3DModel>> getAll3DProducts(String product);
  Future<Product3DModel> getone3DProducts(String productId);
}

class Product3DRemoteDataSourceImpl implements Product3DRemoteDataSource{
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
  Future<List<Product3DModel>> getAll3DProducts(String product)async {
       try {
      await verifyToken();
      final response = await dio.get("${ApiConst.allproduct3D}/$product",
       options: Options(
           headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      print('res $response');
      List<dynamic> data = response.data;
      List<Product3DModel> products3d =
          data.map((e) => Product3DModel.fromJson(e)).toList();
      return products3d;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Product3DModel> getone3DProducts(String productId) async{
      try {
      await verifyToken();
      final response = await dio.get("${ApiConst.product3D}/$productId",
       options: Options(
           headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
     final data = response.data;
      Product3DModel product3d =Product3DModel.fromJson(data);
      return product3d;
    } catch (e) {
      throw ServerException();
    }
  }

}