import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/domain/entities/product3D.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';
import 'package:indar_deco/presentation/controllers/wishlist_controller.dart';
import 'package:indar_deco/presentation/ui/screens/product/product_screen.dart';

// ignore: must_be_immutable
class FavouriteItem extends StatelessWidget {
  final String image;
  final String label;
  final double price;
  final String supplier;
   bool liked;
  final Product3D texture;
   FavouriteItem({super.key,required this.image,required this.label,required this.price,required this.liked,required this.texture,required this.supplier});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: WishListController(),
      id: ControllerID.LIKE_PRODUCT,
      builder: (controller) {
        return GestureDetector(
          onTap: (){
            ProductController productController = Get.find();
                  productController.currentProductid=texture.product;
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ProductScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Container(
               decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.white
              ),
              child: Slidable(
                 endActionPane: ActionPane(
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                                borderRadius: BorderRadius.circular(15),
                                backgroundColor: AppColors.red,
                                icon: Icons.delete,
                                label: AppLocalizations.of(context)!.delete,
                                onPressed: (context) async {
                                 await controller.toggleLikedTexture(texture);                     
                                }),
                          ],
                        ),
                child: Container(
                   decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.white
                ),
                  child: Row(
                    
                    mainAxisSize: MainAxisSize.max,
                    children: [
                       InkWell(
                        onTap: (){
                          ProductController productController = Get.find();
                          productController.currentProductid=texture.product;
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ProductScreen()));
                        },
                         child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(image,height: 100.h,width: 100.w,fit: BoxFit.cover,)),
                       ),
                                const SizedBox(width: 10,),
                       SizedBox(
                        width: 230.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 220.w,
                              child: Text(label,style: AppTextStyle.smallBlackTitleTextStyle,overflow: TextOverflow.ellipsis,)),
                            const SizedBox(height: 10,),
                             SizedBox(
                              width: 220.w,
                               child: Text(supplier,style: AppTextStyle.smallGreyTextStyle,overflow: TextOverflow.ellipsis,)),
                            const SizedBox(height: 10,),
                            Text('${price.toString()}${AppLocalizations.of(context)!.dinar}',style: AppTextStyle.priceTextStyle,overflow: TextOverflow.visible,),
                      
                          ],
                        ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

