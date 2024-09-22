import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:indar_deco/di.dart';
import 'package:indar_deco/domain/entities/promotion.dart';
import 'package:indar_deco/domain/usecases/promotion_usecases/get_all_promotions_usecase.dart';


class PromotionController extends GetxController {
  List<Promotion> promotionsList=[];

  Future<List<Promotion>> getAllPromotions()async{
    if(promotionsList.isEmpty){
    final res = await GetAllPromotionsUsecase(sl())();
    res.fold((l) => null, (r) => promotionsList=r);
    }
    return promotionsList;
  }

  Future<double> getPromotionPrice(String prodId)async{
  if(promotionsList.isEmpty){
    await getAllPromotions();
  }
 return promotionsList.firstWhere((element) => element.product==prodId).newPrice;
  }


}