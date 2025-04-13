import '../../domain/entities/user.dart';

class UserModel extends User{
  const UserModel({super.id,required super.cart,required super.wishlist,  required super.address,required super.image, required super.ban, required super.firstName, required super.lastName, required super.email, required super.phone,  super.password,required super.oAuth,required super.birthDate,required super.gender,required super.recoveryEmail});
 
 factory UserModel.fromJson(Map<String,dynamic> json)=>UserModel(
  id:json['_id'],
  image: json['imageUrl'],
  address: json['address'],
  cart:(json['cart']  as List).map((e) => e.toString()).toList(),
  wishlist:(json['wishlist'] as List).map((e) => e.toString()).toList() ,
  recoveryEmail: json['recoveryEmail'],
  ban: json['ban'],
  oAuth: json['OAuth'],
  gender: json['gender'],
  birthDate: json['birthDate'],
  firstName: json['firstName'],
  lastName: json['lastName'],
  email: json['email'],
  phone: json['phone'],
  password: json['password']
  );

  Map<String,dynamic> toJson()=>{
    'firstName':firstName,
    'lastName':lastName,
    'email':email,
    'OAuth':oAuth,
    'birthDate':birthDate,
    'gender':gender,
    'wishlist':wishlist,
    'cart':cart,
    'phone':phone,
    'address':address,
    'recoveryEmail':recoveryEmail,
    'ban':ban,
    'password':password,
    'imageUrl':image
  };
}