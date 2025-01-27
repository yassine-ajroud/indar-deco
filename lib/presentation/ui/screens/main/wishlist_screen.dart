import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/core/utils/svg.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/cart_controller.dart';
import 'package:indar_deco/presentation/controllers/notifications_controller.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';
import 'package:indar_deco/presentation/controllers/supplier_controller.dart';
import 'package:indar_deco/presentation/controllers/wishlist_controller.dart';
import 'package:indar_deco/presentation/ui/screens/main/cart_screen.dart';
import 'package:indar_deco/presentation/ui/screens/notifications/notifications_screen.dart';
import 'package:indar_deco/presentation/ui/widgets/wishlist/favourite_item.dart';


class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController=Get.find();
    final ProductController productController=Get.find();
    final SupplierController supplierController = Get.find();
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.background,
      body: GetBuilder(
        id: ControllerID.LIKE_PRODUCT,
        init: WishListController(),
        builder: (controller) {
          return FutureBuilder(
            future: controller.getUserWishlist(authenticationController.currentUser.id!),
            builder: (context, snapshot) {
              if(snapshot.hasData){
    return CustomScrollView(
                slivers: [
                    SliverAppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: AppColors.background,
                       shadowColor: AppColors.lightShadow,
                       title: Text(AppLocalizations.of(context)!.wishlist,style: AppTextStyle.appBarTextStyle,),
                              // actions: [IconButton(onPressed: (){
                              //   Navigator.of(context).push(MaterialPageRoute( builder:(_)=>const CartScreen()));
                              // }, icon: SvgPicture.string(APPSVG.cartIcon))],
                            elevation: 4,
      snap: true,
      pinned: true,
      floating: true,
           actions: [
          IconButton(
              onPressed: () {
                 Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const NotificationsScreen()));
              },
              icon: Stack(
                children: [
                  SvgPicture.string(APPSVG.notificationIcon),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GetBuilder(
                      init: NotificationsController(),
                      id: ControllerID.NOTIFICATIONS_COUNT,
                      builder: (notifsController) {
                        return notifsController.unseenCount<1?Container() : CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: 7,
                          child: Text(
                            notifsController.unseenCount.toString(),
                            style: AppTextStyle.cartBadgeTextTextStyle,
                          ),
                        );
                      },
                    ),
                  )
                ],
          )),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CartScreen()));
              },
              icon: Stack(
                children: [
                  SvgPicture.string(APPSVG.cartIcon),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GetBuilder(
                      init: CartController(),
                      builder: (cartController) {
                        return cartController.currentCart.productsId.isEmpty?Container() : CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: 7,
                          child: Text(
                            cartController.currentCart.productsId.length.toString(),
                            style: AppTextStyle.cartBadgeTextTextStyle,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ))
        ],
                      ),  
  const  SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  ),
                    controller.wishlistModel.isNotEmpty?  SliverList.builder(
                        itemCount: controller.wishlistModel.length,
                        itemBuilder: (_,index)=>FavouriteItem(supplier: supplierController.productSupplier(productController.allProducts.firstWhere((element) => element.id==controller.wishlistModel[index].product).provider),  texture:controller.wishlistModel[index] ,image: controller.wishlistModel[index].texture, label:productController.allProducts.firstWhere((element) => element.id== controller.wishlistModel[index].product).name, price: productController.getPrice(productController.allProducts.firstWhere((element) => element.id== controller.wishlistModel[index].product)),
                        liked: controller.getWishlistIds.contains(controller.wishlistModel[index].id),)):
                               SliverToBoxAdapter(
                    child: Center(child: Text(AppLocalizations.of(context)!.empty_wishlis,style: AppTextStyle.blackTextStyle,)),
                  ),
                        const  SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  )
                ],
              );
              }else{
                return const Center(child: CircularProgressIndicator());
              }          
            }
          );
        }
      ),
    ));
  }
}