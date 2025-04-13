import 'package:dio/dio.dart';
import 'package:indar_deco/core/errors/exceptions/exceptions.dart';
import 'package:indar_deco/core/utils/api_const.dart';
import 'package:indar_deco/data/models/category_model.dart';


abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {

 
   final dio = Dio(BaseOptions(
  baseUrl: ApiConst.baseUrl,
  contentType: Headers.jsonContentType,
  validateStatus: (int? status) {
    return status != null;
    // return status != null && status >= 200 && status < 300;
  },
));

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response = await dio.get(
        ApiConst.categories,
      );
      List<dynamic> data = response.data;
      List<CategoryModel> categories =
          data.map((e) => CategoryModel.fromJson(e)).toList();
      return categories;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    }
  }
}
