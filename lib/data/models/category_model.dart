import '../../domain/entities/category.dart';

class CategoryModel extends Category {

  const CategoryModel(
 { 
    required super.id,
    required super.title,
    required super.image
}
    );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      id: json['_id'],
      title: json['title'],
      image: json['image'],
      );

}
