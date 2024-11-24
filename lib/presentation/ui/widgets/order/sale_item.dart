import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/api_const.dart';
import 'package:indar_deco/domain/entities/product.dart';
import 'package:indar_deco/domain/entities/sales.dart';


// ignore: must_be_immutable
class SaleItem extends StatelessWidget {
  bool isSelected=false;
 final Sales sale;
 final Product product;
  SaleItem({super.key, required this.product,required this.sale,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0.r),
      child: SizedBox(
        width:     isSelected? 155.w:140.w,
 
        child: Container(
          decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //       color: AppColors.grey, spreadRadius: 0, blurRadius: 5.r),
              // ],
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15.r)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r),topRight: Radius.circular(15.r)),
                  child: Image.network(
                    product.image,fit: BoxFit.cover,width: double.infinity ,height: isSelected? 120.h:100.h,),
                ),      
                Padding(
                  padding: const EdgeInsets.all( 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: isSelected? 150.w:135.w,
                        child: Text(
                          product.name,
                          overflow:TextOverflow.ellipsis,
                          style: AppTextStyle.smallBlackTitleTextStyle,
                        ),
                      ),const SizedBox(height: 5,),
                       RichText(text: TextSpan(children: [TextSpan( text:"Ref: ",style:AppTextStyle.smallGreyTextStyle ),TextSpan( text:product.reference,style:AppTextStyle.smallGreyTextStyle )])),
                RichText(text: TextSpan(children: [TextSpan( text:"total price: ",style:AppTextStyle.smallGreyTextStyle ),
                TextSpan( text:"${sale.totalPrice}DT",style:AppTextStyle.smallGreyTextStyle )])),
                RichText(text: TextSpan(children: [TextSpan( text:"quantity: ",style:AppTextStyle.smallGreyTextStyle ),
                TextSpan( text:sale.quantity.toString(),style:AppTextStyle.smallGreyTextStyle )])),
                    ],
                  ),
                ),
               
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}