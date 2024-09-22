import 'package:get/get.dart';
import 'package:indar_deco/di.dart';
import 'package:indar_deco/domain/entities/rating.dart';
import 'package:indar_deco/domain/usecases/rating_usecases/add_rating_usecase.dart';
import 'package:indar_deco/domain/usecases/rating_usecases/delete_rating_usecase.dart';
import 'package:indar_deco/domain/usecases/rating_usecases/get_ratings_usecase.dart';
import 'package:indar_deco/domain/usecases/rating_usecases/update_rating_usecase.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';


class RatingController extends GetxController{
    int localRate = 0;
    SimpleRating? userRate;
    late ProductRating productRating;

    void setRating(int rate){
      localRate=rate;
      update();
    }

      Future<void> updateRating(int newRate) async {
      final newRating = SimpleRating(
        id: userRate!.id,
        user: userRate!.user,
        product: userRate!.product,
        rate: newRate);
       final res = await UpdateRatingUsecase(sl()).call(newRating);
      res.fold((l) => print('cant update rating'), (r) {
      getRating(userRate!.product);
      update();
    });
  }

  Future<void> deleteRating(String rateId) async {
    final res = await DeleteRatingUsecase(sl()).call(rateId);
    res.fold((l) => print("cant delete rating"), (r) {
      localRate = 0;
      update();
    });
  }

  Future<void> addRating(int newRating) async {
        AuthenticationController authenticationController= Get.find();
    ProductController productController=Get.find();
    final newRate = SimpleRating(
        user: authenticationController.currentUser.id!,
        product: productController.currentProductid,
        rate: newRating);
    final res = await AddRatingUsecase(sl()).call(newRate);
    res.fold((l) => print('cant add rate'), (r) {
      userRate = r;
      update();
    });
  }

Future<bool> getRating(String prodID) async {
    SimpleRating? existingRate;
    AuthenticationController authenticationController= Get.find();
    final res = await GetRatingsUsecase(sl()).call(prodID);
    res.fold((l) => print('cant get rating'), (r) {
      productRating=r;
      if (r.ratings.isNotEmpty) {
        try {
          existingRate = r.ratings.firstWhere((element) =>
              element.product == prodID &&
              element.user == authenticationController.currentUser.id);
        } catch (e) {
          print('$e this user dont has rating');
        }
      }
    });
    if (existingRate == null) {
      final newRate = SimpleRating(
          user: authenticationController.currentUser.id!, product: prodID, rate: 0);
      userRate = newRate;
    } else {
      userRate = existingRate!;
    }
    localRate = userRate!.rate;
    return true;
  }

  int getUserRating(String prodID,String userID){
    try{
    return productRating.ratings.firstWhere((element) => element.product==prodID&&element.user==userID).rate;

    }catch(e){
      return 0;
    }
  }
  
}