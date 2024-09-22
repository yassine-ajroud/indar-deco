import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/core/utils/svg.dart';
import 'package:indar_deco/presentation/controllers/cart_controller.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';
import 'package:indar_deco/presentation/controllers/wishlist_controller.dart';
import 'package:indar_deco/presentation/ui/screens/main/cart_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProductScreenSliverAppBar extends StatelessWidget {

  const ProductScreenSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    ProductController pc=Get.find();
    return  SliverAppBar(
      centerTitle: true,
      backgroundColor: AppColors.background,
      title: Text( AppLocalizations.of(context)!.product_details,style: AppTextStyle.appBarTextStyle,),
      actions: [ GetBuilder(
                        init: ProductController(),
                        id:ControllerID.PRODUCT_TEXTURE,
                        builder: (context) {
                          return GetBuilder(
                            init: WishListController(),
                            id:ControllerID.LIKE_PRODUCT,
                            builder: (wishListController) {
                              return IconButton(
                                                    padding: EdgeInsets.zero,

                                onPressed: ()async{
                               await   wishListController.toggleLikedTexture(pc.selected3Dproduct);
                                }, icon:  SvgPicture.string((wishListController.likedProduct(pc.selected3Dproduct.id) ?APPSVG.selectedWishlistIcon: APPSVG.wishlistIcon)));
                            }
                          );
                        }
                      ),
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
      elevation: 4,
      snap: true,
      pinned: true,
      floating: true,
   
    );
  }
}

 