import 'package:indar_deco/domain/entities/review.dart';

// ignore: must_be_immutable
class ReviewModel extends Review {
   ReviewModel(
      {required super.userID,
      required super.productID,
      super.date,
      required super.comment,
      required super.image,
      required super.id});

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
      userID: json['user'],
      productID: json['product'],
      comment: json['comment'],
      date:  DateTime.parse(json['updatedAt'].toString()),
      image: json['image']??'',
      id: json['_id']);

  Map<String, dynamic> toJson() => {
        'user': userID,
        'product':productID,
        'comment':comment,
        'image':image
      };
}
