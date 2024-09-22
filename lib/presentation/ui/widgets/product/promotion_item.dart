import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indar_deco/core/styles/text_styles.dart';

class PromotionWidget extends StatelessWidget {
  final String image;
    final String text;
    final int percentage;
  const PromotionWidget({super.key,required this.image,required this.text,required this.percentage});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
             
                          width: double.infinity,
                          height: 200.h,
                          child: Stack(
                            alignment: AlignmentDirectional.centerStart,
                            children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: ColorFiltered(
                                 colorFilter: const ColorFilter.mode(
              Colors.grey,
              BlendMode.modulate,
            ),
                                child: Image.network(image,width: double.infinity,height: 200.h,fit: BoxFit.cover,))),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Text(text,style: AppTextStyle.promotionTextTextStyle,),
                                      Text(' $percentage%',style: AppTextStyle.promotiondiscountTextStyle,),

                                    ],
                                  ),
                                )
                          ],),
                        );
  }
}