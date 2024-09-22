import 'package:dio/dio.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/settings_local_data_source.dart';
import 'package:indar_deco/data/models/wishlist_model.dart';
import '../../../core/errors/exceptions/exceptions.dart';
import '../../../core/utils/api_const.dart';
import '../../models/token_model.dart';

import 'authentication_remote_data_source.dart';

abstract class WishListRemoteDataSource {
  Future<void> createWishlist({required String userId});
  Future<void> updateWishlist({required WishListModel wishlist});
  Future<WishListModel> getWishlist({required String userId});
  Future<void> deleteWishlist({required String wishlistId});

}

class WishListRemoteDataSourceImpl implements WishListRemoteDataSource {

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
  Future<void> createWishlist({required String userId}) async{
     try {
       await dio.post(
        ApiConst.addWishlist,
        data: {"userId": userId,"products":[]},);
    }  catch (e) {
            print("wishlist error ${e.toString()}");

        throw ServerException(message:"add cart error");
      }
    }
  
  
  @override
  Future<WishListModel> getWishlist({required String userId}) async{
    try {
      await verifyToken();
      final response = await dio.get(
        ApiConst.getWishlist,
        data: {"userId":userId},
        options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
          if(response.statusCode==200){
      final data = response.data;
      WishListModel wishlist = WishListModel.fromJson(data);
      return wishlist;
     }else  if(response.statusCode==404){
      throw DataNotFoundException('wishlist not found');
     }else{
        throw ServerException(message:"server error");
     }
    }  catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<void> updateWishlist({required WishListModel wishlist}) async{
   try {
    await verifyToken();
       await dio.put(
        ApiConst.updateWishlist,
        data: {"id": wishlist.id,
              "products": wishlist.productsId
              },
        options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
    } catch (e) {
        throw ServerException(message:"error");
    }
  }
  
  @override
  Future<void> deleteWishlist({required String wishlistId})async {
     try {
          await verifyToken();
       await dio.delete(
        ApiConst.deleteWishlist,
        data: {"id": wishlistId},
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
