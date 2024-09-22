import '../../domain/entities/cart.dart';

// ignore: must_be_immutable
class CartModel extends Cart {
  CartModel(
      {required super.id, required super.userId, required super.productsId});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      id: json['_id'],
      userId: json['userId'],
      productsId:
          (json['sales'] as List).map((e) => e.toString()).toList());

  Map<String, dynamic> toJson() => {
    "_id":id,
    "userId":userId,
    "sales":productsId.map((e) =>{'_id':id}).toList()
  };
}
