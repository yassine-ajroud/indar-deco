import 'package:equatable/equatable.dart';

class Reclamation extends Equatable {
  final String? id;
  final String user;
  final String address;
  final List<dynamic> sales;
  final String reference;
  final double price;
  final DateTime? date;
  final bool? verified;
  final bool? completed;

 const Reclamation({this.id, this.completed, this.verified,  this.date, required this.user, required this.sales, required this.reference,required this.price,required this.address});
 
  @override
  List<Object?> get props =>[id,user,sales,reference,price,date,verified,completed,address];
  
}
