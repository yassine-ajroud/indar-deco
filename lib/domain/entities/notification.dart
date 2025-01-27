class MyNotification{
  final String id;
  final String userId;
  final String senderId;
  final String content;
  final bool seen;
  final DateTime? date;

  const MyNotification({required this.id, required this.userId, required this.senderId, required this.content, required this.seen,  this.date});

}