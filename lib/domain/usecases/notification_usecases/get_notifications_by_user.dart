import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/notification.dart';
import 'package:indar_deco/domain/repositories/notifications_repository.dart';

class GetNotificationByUserUsecase {
  final NotificationRepository _repository;

  GetNotificationByUserUsecase(this._repository);

  Future<Either<Failure,List< MyNotification>>> call({required String userID}) async =>
      await _repository.getNotificationsByUserID(userID: userID);
}