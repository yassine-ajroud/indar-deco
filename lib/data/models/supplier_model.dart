
import 'package:indar_deco/domain/entities/supplier.dart';

class SupplierModel extends Supplier{
 const SupplierModel({required super.rib, required super.marque, required super.id, required super.name, required super.address, required super.phone, required super.userID, required super.image, required super.webSite});

  factory SupplierModel.fromJson(Map<String,dynamic> json)=>SupplierModel(id: json['_id'],
   name: json['name'],
  address: json['address'],
   phone: json['phone'],
   userID: json['userId'],
   image: json['image'],
   marque: json['marque'],
   rib: json['rib'],
   webSite: json['webSite']);  
}
