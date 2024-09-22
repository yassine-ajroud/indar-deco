import '../../domain/entities/wishlist.dart';

// ignore: must_be_immutable
class WishListModel extends WishList {
  WishListModel(
      {required super.id, required super.userId, required super.productsId});

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
      id: json['_id'],
      userId: json['userId'],
      productsId:
          (json['products'] as List).map((e) => e.toString()).toList());

  Map<String, dynamic> toJson() => {
    "_id":id,
    "userId":userId,
    "products":productsId.map((e) =>id).toList()
  };
}
