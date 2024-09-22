import 'package:equatable/equatable.dart';

class SimpleRating extends Equatable{
 final String? id;
 final String user;
 final String product;
 final int rate;

 const SimpleRating({ this.id, required this.user, required this.product, required this.rate});
  @override
  List<Object?> get props =>[id,user,product,rate];

}

class ProductRating extends Equatable{
 final List<SimpleRating> ratings;
 final int number;
 final double avg;
 final int oneStar;
  final int twoStars;
 final int threeStars;
 final int fourStars;
 final int fiveStars;

 const ProductRating({required this.ratings, required this.number, required this.avg, required this.oneStar, required this.twoStars, required this.threeStars, required this.fourStars, required this.fiveStars});
 
  @override
  List<Object?> get props => [ratings,number,avg,oneStar,twoStars,threeStars,fourStars,fiveStars];

}