import 'package:dio/dio.dart';
import 'package:indar_deco/core/utils/api_const.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/settings_local_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:indar_deco/data/models/sales_model.dart';
import 'package:indar_deco/data/models/token_model.dart';
import '../../../core/errors/exceptions/exceptions.dart';

abstract class SalesRemoteDataSource{
  Future<List<SalesModel>> getAllSales(String userId);
  Future<SalesModel> getSingleSales(String id);
  Future<void> deleteSales(String id);
  Future<SalesModel> addSale(SalesModel newSale);
Future<void> updateSale(SalesModel updateSale);
}

class SalesRemoteDataSourceImp implements SalesRemoteDataSource{
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
  Future<SalesModel> addSale(SalesModel newSale) async {
      try {
      final res = await dio.post(ApiConst.addSale, data: newSale.toJson(),
       options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
     return SalesModel.fromJson(res.data['sale']); 
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<SalesModel>> getAllSales(String userId) async{
     try {
      final response = await dio.get('${ApiConst.allSales}/$userId',
       options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      List<dynamic> data = response.data;
      List<SalesModel> sales =
          data.map((e ) => SalesModel.fromJson(e)).toList();
      return sales;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<SalesModel> getSingleSales(String id) async{
       try {
      final response = await dio.get('${ApiConst.oneSale}/$id',
       options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      final data = response.data;
      return SalesModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }
  
  @override
  Future<void> deleteSales(String id) async{
     try {
       await dio.delete('${ApiConst.oneSale}/$id',
        options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
    } catch (e) {
      throw ServerException();
    }
  }
  
  @override
  Future<void> updateSale(SalesModel updateSale) async{
    try {
    await dio.put("${ApiConst.oneSale}/${updateSale.id}",
          data: updateSale.toJson(),
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