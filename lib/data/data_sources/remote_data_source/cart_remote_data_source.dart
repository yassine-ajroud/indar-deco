import 'package:dio/dio.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/settings_local_data_source.dart';
import '../../../core/errors/exceptions/exceptions.dart';
import '../../../core/utils/api_const.dart';
import '../../models/cart_model.dart';
import '../../models/token_model.dart';

import 'authentication_remote_data_source.dart';

abstract class CartRemoteDataSource {
  Future<void> createCart({required String userId});
  Future<void> updateCart({required CartModel cart});
  Future<CartModel> getCart({required String userId});
  Future<void> deleteCart({required String cartId});

}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {

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
  Future<void> createCart({required String userId}) async{
     try {
             await dio.post(
        ApiConst.addCart,
        data: {"userId": userId,"sales":[]},);
    }  catch (e) {
      print("cart error ${e.toString()}");
        throw ServerException(message:"add cart error");
      }
    }
  
  
  @override
  Future<CartModel> getCart({required String userId}) async{
    try {
      final response = await dio.get(
        ApiConst.getCart,
        data: {"userId":userId},
        options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
          if(response.statusCode==200){
      final data = response.data;
      CartModel cart = CartModel.fromJson(data);
      return cart;
     }else  if(response.statusCode==404){
      throw DataNotFoundException('cart not found');
     }else{
        throw ServerException(message:"server error");
     }
    }  catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<void> updateCart({required CartModel cart}) async{
   try {
    print('my cart ${cart.toJson()}');
       await dio.put(
        ApiConst.updateCart,
        data: {"id": cart.id,
              "sales": cart.productsId
              },
        options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
    } catch (e) {
      print("cart error ${e.toString()}");
        throw ServerException(message:"error");
    }
  }
  
  @override
  Future<void> deleteCart({required String cartId})async {
     try {
       await dio.delete(
        ApiConst.deleteCart,
        data: {"id": cartId},
        options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
    } catch (e) {
        throw ServerException(message:"error");
    }
  }

 
}
