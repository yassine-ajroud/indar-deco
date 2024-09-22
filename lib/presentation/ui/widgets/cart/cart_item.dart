import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/domain/entities/sales.dart';
import 'package:indar_deco/presentation/controllers/cart_controller.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';
import 'package:indar_deco/presentation/controllers/supplier_controller.dart';
import 'package:indar_deco/presentation/ui/screens/product/product_screen.dart';

class CartItem extends StatelessWidget {
  final Sales sale;
  const CartItem({super.key,required this.sale});

  @override
  Widget build(BuildContext context) {
   ProductController productController = Get.find();
      SupplierController supplierController = Get.find();

    return GetBuilder(
      init: CartController(),
              id: ControllerID.SALE_QUANTITY,
      builder: (controller) {
        return Padding(
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
                              backgroundColor: AppColors.primary,
                              icon: Icons.delete,
                              label: AppLocalizations.of(context)!.delete,
                              onPressed: (context) async {
                               await controller.deleteSale(sale.id!);                     
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
                        productController.currentProductid=sale.productId;
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ProductScreen()));
                      },
                       child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(controller.cartProducts.firstWhere((element) => element.id==sale.modelId).texture,height: 100.h,width: 100.w,fit: BoxFit.cover,)),
                     ),
                              const SizedBox(width: 10,),
                     SizedBox(
                      width: 170.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: Text(productController.allProducts.firstWhere((element) => element.id==sale.productId).name,style: AppTextStyle.smallBlackTitleTextStyle,overflow: TextOverflow.ellipsis,)),
                          const SizedBox(height: 10,),
                           SizedBox(
                            width: 150.w,
                             child: Text(supplierController.productSupplier(productController.allProducts.firstWhere((element) => element.id==sale.productId).provider),style: AppTextStyle.smallGreyTextStyle,overflow: TextOverflow.ellipsis,)),
                          const SizedBox(height: 10,),
                          Text('${sale.totalPrice}${AppLocalizations.of(context)!.dinar}',style: AppTextStyle.priceTextStyle,overflow: TextOverflow.visible,),
                    
                        ],
                      )),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                                                        color: AppColors.primary,

                          ),
                          width: 60.w,
                          height: 30.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                         GestureDetector(
                          onTap:()async=>  await controller.decrimentSaleQuantity(sale.id!),
                          child:const Icon(Icons.remove,color: AppColors.white,size: 18)), 
                          Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(sale.quantity.toString(),style: AppTextStyle.whiteTextStyle,),
                          ) ,
                           GestureDetector(
                           onTap:()async=>  await controller.incrementSaleQuantity(sale.id!),
                            child:const Icon(Icons.add,color: AppColors.white,size: 18,)),  

                          ]),
                        ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}