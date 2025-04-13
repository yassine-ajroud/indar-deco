import 'package:indar_deco/domain/entities/reclamation.dart';

class ReclamationModel extends Reclamation{
  const ReclamationModel({super.id,required super.address, super.completed,  super.date, required super.user, required super.sales, required super.reference, required super.price,  super.verified});

  factory ReclamationModel.fromJson(Map<String,dynamic> json)=>ReclamationModel(
   id:json['_id'], 
   date: DateTime.parse(json['createdAt']),
   user: json['user'],
   sales: json['sales'],
   address: json['address'],
   reference: json['reference'],
   price: double.parse(json['price'].toString()),
   completed: json['completed'],
   verified: json['verified']
   );


  Map<String , dynamic> toJson()=>{
    'user':user,
    'sales':sales,
    'reference':reference,
    'address':address,
    'price':price,
  }; 
}