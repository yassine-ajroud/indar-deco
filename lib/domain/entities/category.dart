import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String title;
  final String id;
  final String image;
  

  const Category(
 { 
    required this.id,
    required this.title,
    required this.image
}
    );

  @override
  List<Object?> get props => [id,title,image];
}