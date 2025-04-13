import 'package:indar_deco/domain/entities/rating.dart';

class SimpleRatingModel extends SimpleRating{
 const SimpleRatingModel({required super.id, required super.user, required super.product, required super.rate});

  factory SimpleRatingModel.fromJson(Map<String, dynamic> json) => SimpleRatingModel(
      id: json['_id'],
      user: json['user'],
      product: json['product'],
      rate: json['rating']);

  Map<String, dynamic> toJson() => {
    'user':user,
    'product':product,
    'rating':rate
  };
}

class ProductRatingModel extends ProductRating{
 const ProductRatingModel({required super.ratings, required super.number, required super.avg, required super.oneStar, required super.twoStars, required super.threeStars, required super.fourStars, required super.fiveStars});
  
  factory ProductRatingModel.fromJson(Map<String, dynamic> json) => ProductRatingModel(
      oneStar: json['oneStar'],
      twoStars: json['twoStars'],
      threeStars:json['threeStars'], 
      fourStars:json['fourStars'], 
      fiveStars:json['fiveStars'], 
      avg:double.parse( json['avg'].toString()) ,
      ratings: (json['simpleReviews']as List).map((e) => SimpleRatingModel.fromJson(e)).toList(),
      number: json['number']);

}