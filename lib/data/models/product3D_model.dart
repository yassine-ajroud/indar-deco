// ignore: file_names

import 'package:indar_deco/domain/entities/product3D.dart';

class Product3DModel extends Product3D {
 const  Product3DModel({required super.model3D, required super.texture,required super.quantity, required super.id,required super.product});

  factory Product3DModel.fromJson(Map<String, dynamic> json) =>
      Product3DModel(model3D: json['image3D'], texture: json['imageCouleurs'],quantity:json['quantity'] ,id:json['_id'],product:json['prodId']);
  
}
