import 'package:dio/dio.dart';
import 'package:indar_deco/core/errors/exceptions/exceptions.dart';
import 'package:indar_deco/core/utils/api_const.dart';
import 'package:indar_deco/data/models/sub_category.dart';
import 'package:indar_deco/domain/entities/sub_catergory.dart';

abstract class SubCategoryRemoteDataSource {
  Future<List<SubCategory>> getAllSubCategories();
}

class SubCategoryRemoteDataSourceImpl implements SubCategoryRemoteDataSource {



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
      final response = await dio.get(
        ApiConst.subCategories,
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
