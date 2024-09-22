import 'package:dio/dio.dart';
import 'package:indar_deco/core/errors/exceptions/exceptions.dart';
import 'package:indar_deco/core/utils/api_const.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/settings_local_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:indar_deco/data/models/sub_category.dart';
import 'package:indar_deco/data/models/token_model.dart';
import 'package:indar_deco/domain/entities/sub_catergory.dart';

abstract class SubCategoryRemoteDataSource {
  Future<List<SubCategory>> getAllSubCategories();
}

class SubCategoryRemoteDataSourceImpl implements SubCategoryRemoteDataSource {

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
  Future<List<SubCategoryModel>> getAllSubCategories() async {
    try {
      await verifyToken();
      final response = await dio.get(
        ApiConst.subCategories,
        options: Options(
           headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),
      );
      List<dynamic> data = response.data;
      List<SubCategoryModel> subCategories =
          data.map((e) => SubCategoryModel.fromJson(e)).toList();
      return subCategories;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    }
  }

  

}
