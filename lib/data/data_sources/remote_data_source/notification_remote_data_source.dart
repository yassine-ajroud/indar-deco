import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:indar_deco/core/errors/exceptions/exceptions.dart';
import 'package:indar_deco/core/utils/api_const.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/settings_local_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:indar_deco/data/models/notification_model.dart';
import 'package:indar_deco/data/models/token_model.dart';

abstract class NotificationRemoteDataSource {
  Future<MyNotificationModel> updateNotification(MyNotificationModel notification);
  Future<MyNotificationModel> getNotificationByID(String notificationID);
  Future<List<MyNotificationModel>> getNotificationByUserID(String userID);
  Future<MyNotificationModel> deleteNotification(String notificationID);
}

Future<TokenModel> get token async {
  return await AuthenticationLocalDataSourceImpl().getUserInformations();
}

Future<String> get locale async {
  return await SettingsLocalDataSourcImpl().loadLocale();
}

Future<void> verifyToken() async {
  return await token.then((value) async {
    if (value.expiryDate.isBefore(DateTime.now())) {
      final newToken = await AuthenticationRemoteDataSourceImpl()
          .refreshToken(value.refreshToken, value.userId);
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

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  @override
  Future<MyNotificationModel> deleteNotification(String notificationID) async {
    try {
      await verifyToken();

      final res =
          await dio.delete("${ApiConst.deleteNotifications}/$notificationID",
              options: Options(
                headers: {
                  "authorization":
                      "Bearer ${await token.then((value) => value.token)}",
                },
              ));
      return MyNotificationModel.fromJson(jsonDecode(res.data));
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<MyNotificationModel> getNotificationByID(String notificationID) async {
    try {
      await verifyToken();
      final res =
          await dio.get("${ApiConst.getOneNotification}/$notificationID",
              options: Options(
                headers: {
                  "authorization":
                      "Bearer ${await token.then((value) => value.token)}",
                },
              ));
      return MyNotificationModel.fromJson(jsonDecode(res.data));
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MyNotificationModel>> getNotificationByUserID(
      String userID) async {
    try {
      await verifyToken();

      final res = await dio.get("${ApiConst.getUerNotifications}/$userID",
          options: Options(
            headers: {
              "authorization":
                  "Bearer ${await token.then((value) => value.token)}",
            },
          ));
      List<dynamic> data = res.data;
      return data.map((e) => MyNotificationModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<MyNotificationModel> updateNotification(MyNotificationModel notification) async{
    try {
      await verifyToken();

      final res = await dio.put(ApiConst.updateNotifications,
      data: notification.toJson(),
          options: Options(
            headers: {
              "authorization":
                  "Bearer ${await token.then((value) => value.token)}",
            },
          ));
      return MyNotificationModel.fromJson(jsonDecode(res.data));
    } catch (e) {
      throw ServerException();
    
  }
  }
}
