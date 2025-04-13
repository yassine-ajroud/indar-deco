
import 'package:indar_deco/domain/entities/promotion.dart';

class PromotionModel extends Promotion {
  const PromotionModel(
      {required super.id,
      required super.product,
      required super.discount,
      required super.startDate,
      required super.endDate,
      required super.newPrice,
      required super.text,
      required super.image});

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
      id: json['_id'],
      product:json['product'],
      discount: json['discountPercentage'],
      text: json['text'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      newPrice:double.parse(json['newPrice'].toString()),
      image: json['image']);
}
