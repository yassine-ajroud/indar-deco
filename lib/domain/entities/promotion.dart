import 'package:equatable/equatable.dart';

class Promotion extends Equatable {
  final String id;
  final String product;
  final int discount;
  final DateTime startDate;
  final DateTime endDate;
  final String image;
  final String text;
  final double newPrice;

  const Promotion(
      {
      required this.id, 
      required this.newPrice,
      required this.product,
      required this.discount,
      required this.startDate,
      required this.endDate,
      required this.text,
      required this.image});

  @override
  List<Object?> get props => [id,product, discount, startDate, endDate, image, newPrice,text];
}
