import '../../domain/entities/user.dart';

class UserModel extends User{
  const UserModel({super.id,required super.address,required super.image, required super.ban, required super.firstName, required super.lastName, required super.email, required super.phone,  super.password,required super.oAuth,required super.birthDate,required super.gender,required super.recoveryEmail});
 
 factory UserModel.fromJson(Map<String,dynamic> json)=>UserModel(
  id:json['_id'],
  image: json['imageUrl'],
  address: json['address'],
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
    'phone':phone,
    'address':address,
    'recoveryEmail':recoveryEmail,
    'ban':ban,
    'password':password,
    'imageUrl':image
  };
}