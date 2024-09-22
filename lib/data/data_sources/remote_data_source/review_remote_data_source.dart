import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:indar_deco/core/utils/api_const.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/settings_local_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:indar_deco/data/models/review_model.dart';
import 'package:indar_deco/data/models/token_model.dart';

import '../../../core/errors/exceptions/exceptions.dart';

abstract class ReviewRemoteDataSource {
  Future<ReviewModel> addReview(ReviewModel reviewModel);
  Future<List<ReviewModel>> getAllReviews(String prodId);
  Future<void> updateReview(ReviewModel review);
  Future<void> removeReview(String id);
  Future<void> addReviewImage(String reviewId,File file);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
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
  Future<ReviewModel> addReview(ReviewModel review) async {
    try {
            await verifyToken();

   final res = await dio.post("${ApiConst.products}/${review.productID}/reviews",
          data: review.toJson(),
            options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
        return ReviewModel.fromJson(res.data['review']);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ReviewModel>> getAllReviews(String prodId) async {
    try {
      await verifyToken();
      final response = await dio.get("${ApiConst.products}/$prodId/reviews",
              options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ),);
      List<dynamic> data = response.data;
      List<ReviewModel> reviews =
          data.map((e) => ReviewModel.fromJson(e)).toList();
      return reviews;
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<void> removeReview(String prodId) async {
    try {
            await verifyToken();

      await dio.delete("${ApiConst.reviews}/$prodId",
              options: Options(
          headers: {
            "authorization": "Bearer ${await token.then((value) => value.token)}",
          },
        ));
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateReview(ReviewModel review) async {
    try {
            await verifyToken();

      await dio.put("${ApiConst.reviews}/${review.id}",
          data: review.toJson(),
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
  Future<void> addReviewImage(String reviewId, File file) async{
     try {
String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
        'id':reviewId,
        "file":
            await MultipartFile.fromFile(file.path, filename:fileName,contentType: MediaType("image","jpeg")),
    });

      await dio.put(ApiConst.uploadReviewImage, data: formData);
    } catch (e) {
      throw ServerException(message: 'cannot update image');
    }
  }
}
