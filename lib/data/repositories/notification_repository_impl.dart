import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/exceptions/exceptions.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/notification_remote_data_source.dart';
import 'package:indar_deco/data/models/notification_model.dart';
import 'package:indar_deco/domain/entities/notification.dart';
import 'package:indar_deco/domain/repositories/notifications_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;

  NotificationRepositoryImpl(this.notificationRemoteDataSource);
  @override
  Future<Either<Failure, MyNotification>> deleteNotification(
      {required String notificationID}) async {
    try {
      final res =
          await notificationRemoteDataSource.deleteNotification(notificationID);
      return right(res);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MyNotification>> getNotificationById(
      {required String notificationID}) async {
    try {
      final res = await notificationRemoteDataSource
          .getNotificationByID(notificationID);
      return right(res);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<MyNotification>>> getNotificationsByUserID(
      {required String userID}) async {
    try {
      final res =
          await notificationRemoteDataSource.getNotificationByUserID(userID);
      return right(res);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MyNotification>> updateNotification(
      {required MyNotification notification}) async {
    try {
      final notificationModel = MyNotificationModel(
          id: notification.id,
          userId: notification.userId,
          senderId: notification.senderId,
          content: notification.content,
          seen: notification.seen);
      final res = await notificationRemoteDataSource
          .updateNotification(notificationModel);
      return right(res);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }
}
