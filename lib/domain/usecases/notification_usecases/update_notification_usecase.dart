import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/notification.dart';
import 'package:indar_deco/domain/repositories/notifications_repository.dart';

class UpdateNotificationUsecase {
  final NotificationRepository _repository;

  UpdateNotificationUsecase(this._repository);

  Future<Either<Failure, MyNotification>> call({required MyNotification notification}) async =>
      await _repository.updateNotification(notification: notification);
}
