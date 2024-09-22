
import '../../domain/entities/product.dart';

// ignore: must_be_immutable
class ProductModel extends Product {
  const ProductModel(
      {
      required super.category,  
      required super.id,  
      required super.name,
      required super.description,
      required super.price,
      required super.subCategory,
      required super.image,
      required super.dimensions,
      required super.provider,
      required super.reference, required super.materials, required super.promotion, required super.sales, required super.rate
});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(id: json['_id'],category: json['category'],reference: json['reference'],
      name: json['name'], description: json['description'], price: double.parse(json['price'].toString()) ,subCategory:json['subCategory'],
      image: json['image'],promotion:json['promotion'],sales: json['sales'],rate:double.parse(json['rate'].toString()),
      provider:json['supplier'],dimensions:LocalDimensionsModel.fromJson(json['dimensions']), materials: json['materials'] );

  Map<String, dynamic> toJson() => {
        '_id':id,
        'reference':reference,
        'category':category,
        'subCategory':subCategory,
        'dimensions':dimensions,
        'supplier':provider,
        'materials':materials,
        'sales':sales,
        'promotion':promotion,
        'name': name,
        'description': description,
        'price': price,
        'image':image,
      };
}

class LocalDimensionsModel extends LocalDimensions{
  const LocalDimensionsModel({super.height,super.width,super.thickness});
  factory LocalDimensionsModel.fromJson(Map<String,dynamic> json)=>LocalDimensionsModel(height: double.tryParse(json['height'].toString()),width: double.tryParse(json['width'].toString()),thickness: double.tryParse(json['thickness'].toString()));
}

