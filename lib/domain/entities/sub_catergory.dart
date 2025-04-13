import 'package:equatable/equatable.dart';

class SubCategory extends Equatable {
  final String title;
  final String id;
  final String image;


  const SubCategory(
 { 
    required this.id,
    required this.title,
    required this.image
}
    );

  @override
  List<Object?> get props => [id,title,image];
}