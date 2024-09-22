import 'package:equatable/equatable.dart';

class Supplier extends Equatable {
  final String name;
  final String address;
  final String phone;
  final String userID;
  final String id;
  final String image;
  final String rib;
  final String marque;
  final String? webSite; 

  const Supplier({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.userID,
    required this.image,
    required this.marque,
    required this.rib,
    required this.webSite
  });

  @override
  List<Object?> get props => [
        name,
        id,
        address,
        phone,
        userID,
        image,
        webSite,
        marque,
        rib
      ];
}
