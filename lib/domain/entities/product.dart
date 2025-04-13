import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Product extends Equatable{
  final String? id;
  final String name;
  final String reference;
  final String description;
  final double price;
  final String image;
  final String materials;
  final bool promotion;
  final int sales;
  final double rate;
  final String provider;
  final LocalDimensions dimensions;
  final String category;
  final String subCategory;

  const Product({required this.id, required this.name, required this.reference, required this.description, required this.price,
   required this.image, required this.materials, required this.promotion, required this.sales, required this.rate, required this.provider,
   required this.dimensions, required this.category,required this.subCategory});

  @override
  List<Object?> get props => [id, name, reference,description,price,image,materials,promotion,sales,rate,provider,dimensions,category,subCategory];
}



class LocalDimensions extends Equatable{
  final double? length;
  final double? width;
  final double? height;
  final double? radius;

 const LocalDimensions({ this.length, this.width,this.height, this.radius});
 
  @override
  List<Object?> get props => [height,width,length,radius];
}

