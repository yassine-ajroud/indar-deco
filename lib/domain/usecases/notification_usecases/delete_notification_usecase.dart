import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/notification.dart';
import 'package:indar_deco/domain/repositories/notifications_repository.dart';

class DeleteNotificationUsecase {
  final NotificationRepository _repository;

  DeleteNotificationUsecase(this._repository);

  Future<Either<Failure, MyNotification>> call({required String notificationID}) async =>
      await _repository.deleteNotification(notificationID: notificationID);
}
