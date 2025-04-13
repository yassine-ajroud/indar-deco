
import 'package:dio/dio.dart';
import 'package:indar_deco/core/errors/exceptions/exceptions.dart';
import 'package:indar_deco/core/utils/api_const.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/settings_local_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:indar_deco/data/models/product_model.dart';
import 'package:indar_deco/data/models/token_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getSortedProducts();
  Future<ProductModel> getOneProducts({required String id});
  Future<List<ProductModel>> getProductsByCategory({required String category});
  Future<List<ProductModel>> getProductsBySubCategory({required String category,required subCategory});

}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
 
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
  Future<List<ProductModel>> getAllProducts() async {
    try {
              await verifyToken();
      final response = await dio.get(
        ApiConst.products,
          options: Options(
           headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),
      );
      List<dynamic> data = response.data;
      List<ProductModel> products =
          data.map((e) => ProductModel.fromJson(e)).toList();
      return products;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<ProductModel> getOneProducts({required String id}) async {
    ProductModel prod;

    try {
              await verifyToken();
      final response = await dio.get("${ApiConst.products}/$id",
        options: Options(
           headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      final data = response.data;
      prod = ProductModel.fromJson(data);
      return prod;
    }on DioException catch (e) {
      print('prod error ${e.toString()}');
      if (e.response!.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(
      {required String category}) async {
    try {
              await verifyToken();
      final response = await dio.get(
        "${ApiConst.category}/$category",
          options: Options(
           headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),
      );
      List<dynamic> data = response.data;
      List<ProductModel> products =
          data.map((e) => ProductModel.fromJson(e)).toList();
      return products;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    }
  }
  
  @override
  Future<List<ProductModel>> getProductsBySubCategory({required String category, required subCategory}) async{
     try {
              await verifyToken();
      final response = await dio.get(
        "${ApiConst.category}/$category/subcategory/$subCategory",
        options: Options(
           headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),
      );

      List<dynamic> data = response.data;
      List<ProductModel> products =
          data.map((e) => ProductModel.fromJson(e)).toList();
      return products;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    }
  }
  
  @override
  Future<List<ProductModel>> getSortedProducts() async{
      try {
              await verifyToken();
      final response = await dio.get(
        ApiConst.sortdproducts,
        options: Options(
           headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),
      );
      final data = response.data;
        List<ProductModel> products =[];
        for (Map<String,dynamic>json in data){
          products.add(ProductModel.fromJson(json));
        }
      return products;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    }
  }


}
