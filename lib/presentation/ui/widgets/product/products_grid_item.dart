import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';
import 'package:indar_deco/presentation/controllers/promotion_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/presentation/ui/screens/product/product_screen.dart';

class ProductGridItem extends StatelessWidget {
  final String id;
  final String image;
  final String name;
  final double price;
  final bool promo; 
  final double rating;
  final String reference;
  final String supplier;
  const ProductGridItem({super.key,required this.image,required this.name,required this.price, this.promo=false,required this.id,required this.rating,required this.reference,required this.supplier});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: ProductController(),
      builder: (controller) {
        return InkWell(
          onTap: (){
             controller.setProductId=id;
            Navigator.of(context).push(MaterialPageRoute( builder:(_)=>const ProductScreen()));
          },
          child: Container(
            height: 170.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              
              children: [
                Stack(
                children: [
                  SizedBox(               
                    width: 170.w,
                    height: 150.h,
                   child: ClipRRect(
                      borderRadius:const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                      child: Image.network(image,fit: BoxFit.cover,)),
                  ),
                  // const Positioned(
                  //   top:10,
                  //   right:10,
                  //    child: CircleAvatar(
                  //     backgroundColor: AppColors.lightgrey,
                  //     radius: 15,
                  //     child: Icon(Icons.favorite_outline,color: AppColors.black,size: 20,)),
                  //  ),
                ],
                ),
                   Padding(
                     padding: const EdgeInsets.only(left:8.0,right: 8,top: 4),
                     child: SizedBox(width: 170.w, child: Text(name,style: AppTextStyle.smallBlackTitleTextStyle, overflow: TextOverflow.ellipsis,  maxLines: 1,
                      softWrap: false,)),
                   ),
                        Padding(
                     padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 1),
                     child: SizedBox(width: 170.w, child: Text('Ref: $reference',style: AppTextStyle.smallBlackTextStyle, overflow: TextOverflow.ellipsis,  maxLines: 1,
                      softWrap: false,)),
                   ),
                   SizedBox(
                    width: 165.w,
                     child: Padding(
                     padding: const EdgeInsets.only(left:8.0,right: 8,bottom: 4),
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           SizedBox(width: 90.w, child: Text(supplier,style: AppTextStyle.smallGreyTextStyle,overflow: TextOverflow.ellipsis,)),
                           promo?GetBuilder<PromotionController>(
                              init: PromotionController(),
                              builder: (promoController)  { 
                                return FutureBuilder(
                                future:promoController.getPromotionPrice(id) ,
                                builder: (context, snapshot) {
                                   return Text.rich(TextSpan(children:[TextSpan(text: "${snapshot.data.toString()}${AppLocalizations.of(context)!.dinar}",style: AppTextStyle.priceTextStyle,)] ));
                                }
                                );
                                 
                              }
                            ):Text('$price${AppLocalizations.of(context)!.dinar}',style: AppTextStyle.priceTextStyle,),
                         ],
                       ),
                     ),
                   )
                  
              ],
            ),
          ),
        );
      }
    );
  }
}