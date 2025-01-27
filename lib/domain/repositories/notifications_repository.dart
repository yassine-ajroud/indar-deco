import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, MyNotification>> updateNotification({required MyNotification notification});
  Future<Either<Failure,MyNotification>> getNotificationById({required String notificationID});
  Future<Either<Failure,List<MyNotification>>> getNotificationsByUserID({required String userID});
  Future<Either<Failure, MyNotification>> deleteNotification({required String notificationID});
}
