import 'package:indar_deco/domain/entities/sales.dart';

// ignore: must_be_immutable
class SalesModel extends Sales{
  SalesModel({ super.id,required super.modelId,required super.productId,required super.providerId,required super.userId,required super.quantity,required super.status,required super.totalPrice});
  factory SalesModel.fromJson(Map<String,dynamic>json)=>SalesModel(
    id:json['_id'],
   productId:json['productId'],
   providerId: json['fournisseurId'],
    userId:json['UserId'],
     quantity:json['quantity'], 
     modelId: json['modelId'],
     status:((json['status'])as List).map((e) => SaleStatusModel.fromJson(e)).toList(),
    totalPrice:double.parse(json['price'].toString()));

   Map<String,dynamic> toJson()=>{
    'productId':productId,
    'fournisseurId':providerId,
    'UserId':userId,
    'modelId':modelId,
    'quantity':quantity,
    'price':totalPrice,
    'status':[]
   };   
}

class SaleStatusModel extends SaleStatus{
 const SaleStatusModel({required super.index, required super.date, required super.status});
 factory SaleStatusModel.fromJson(Map<String,dynamic> json)=>SaleStatusModel(index: json['index'], date: json['date'], status: json['status']);
}