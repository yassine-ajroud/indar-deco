import 'package:get/get.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/di.dart';
import 'package:indar_deco/domain/entities/product3D.dart';
import 'package:indar_deco/domain/usecases/authentication_usecases/update_wishlist_usecase.dart';
import 'package:indar_deco/domain/usecases/product_3d_usecases/get_3d_product_by_id_usecase.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';


class WishListController extends GetxController{
late  List<String> currentWishlist;
List<Product3D> wishlistModel=[];
final AuthenticationController authenticationController = Get.find();

Future<List<String>> getUserWishlist(String userId)async{
currentWishlist=[];
wishlistModel=[];
//  final res= await GetWishListUsecase(sl())(userId: userId);
//  res.fold((l) => null, (r) =>currentWishlist=r );
currentWishlist=authenticationController.currentUser.wishlist;
 await getWishlistTextures(currentWishlist);
 return authenticationController.currentUser.wishlist;
}

// Future<void> addUserWishlist(String userId)async{
//  await CreateWishListUsecase(sl())(userId: userId);
// }

Future<void> updateUserWishlist()async{
 //await UpdateWishListUsecase(sl())(wishlist: newWishList);
 await UpdateUserWishlistUsecase(sl())(id:authenticationController.currentUser.id,wishlist: currentWishlist);
 await authenticationController.getCurrentUser(authenticationController.currentUser.id!);
 //await getUserWishlist(authenticationController.currentUser.id!);
}

Future<List<Product3D>> getWishlistTextures(List<String> prods)async{
  wishlistModel=[];
  for (var element in prods) {
   final  res = await Get3DProductsByIdUseCase(sl())(element);
   res.fold((l) => null, (r) => wishlistModel.add(r)); 
  }
  return wishlistModel;
}

bool likedProduct(String textureId){
 return getWishlistIds.contains(textureId);
}

 List<String> get getWishlistIds=> wishlistModel.map((e) => e.id).toList();

Future toggleLikedTexture(Product3D texture)async{
  if(wishlistModel.contains(texture)){
    wishlistModel.remove(texture);
  }else{
    wishlistModel.add(texture);
  }
  currentWishlist=getWishlistIds;
 await updateUserWishlist(); 
update([ControllerID.LIKE_PRODUCT]);
}
}