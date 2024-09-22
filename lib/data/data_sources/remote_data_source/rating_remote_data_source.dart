import 'package:dio/dio.dart';
import 'package:indar_deco/core/errors/exceptions/exceptions.dart';
import 'package:indar_deco/core/utils/api_const.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/settings_local_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:indar_deco/data/models/rating_model.dart';
import 'package:indar_deco/data/models/token_model.dart';

abstract class RatingRemoteDataSource {
  Future<SimpleRatingModel> addRating(SimpleRatingModel rating);
  Future<ProductRatingModel> getRatings(String productID);
  Future<SimpleRatingModel> getSingleRating(String ratingID);
  Future<SimpleRatingModel> updateRating(SimpleRatingModel newRating);
  Future<void> deleteRating(String ratingID);
}

class RatingRemoteDataSourceImpl implements RatingRemoteDataSource {

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
  Future<SimpleRatingModel> addRating(SimpleRatingModel rating) async {
    try {
      final response = await dio.post(ApiConst.ratings, data: rating.toJson(),
       options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      final data = response.data['review'];
      return SimpleRatingModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRating(String ratingID) async {
    try {
      await dio.delete('${ApiConst.ratings}/$ratingID',
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
  Future<ProductRatingModel> getRatings(String productID) async {
    try {
      final response = await dio.get("${ApiConst.productRatings}/$productID/ratings",
       options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      dynamic data = response.data;
      ProductRatingModel ratings =ProductRatingModel.fromJson(data);
      return ratings;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<SimpleRatingModel> getSingleRating(String ratingID) async {
    try {
      final response = await dio.get('${ApiConst.ratings}/$ratingID',
       options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      final data = response.data;
      return SimpleRatingModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<SimpleRatingModel> updateRating(SimpleRatingModel newRating) async {
    try {
      final response = await dio.put('${ApiConst.ratings}/${newRating.id}',
       options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),
          data: newRating.toJson());
      final data = response.data;
      return SimpleRatingModel.fromJson(data);
    } catch (e) {
      throw ServerException();
    }
  }
  

}
