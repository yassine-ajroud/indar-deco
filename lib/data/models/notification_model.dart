import 'package:indar_deco/domain/entities/notification.dart';

class MyNotificationModel extends MyNotification {
  const MyNotificationModel(
      {required super.id,
      required super.userId,
      required super.senderId,
      required super.content,
      required super.seen,
      super.date});

  factory MyNotificationModel.fromJson(Map<String, dynamic> json) =>
      MyNotificationModel(
          id: json['_id'],
          userId: json['userId'],
          senderId: json['senderId'],
          content: json['content'],
          seen: json['seen'],
          date: DateTime.parse(json['createdAt'].toString()));

  Map<String, dynamic> toJson() => {
        'id':id,
        'userId': userId,
        'senderId': senderId,
        'content': content,
        'seen': seen
      };
}
