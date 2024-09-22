import 'package:equatable/equatable.dart';

class Product3D extends Equatable {
 final  String model3D;
 final  String texture;
 final  int quantity;
 final String product;
  final String id;

  const Product3D(
      {required this.model3D, required this.texture, required this.quantity,required this.id,required this.product});

  @override
  List<Object?> get props => [model3D, texture, quantity,id,product];
}
