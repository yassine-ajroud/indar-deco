import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/core/l10n/plural_strings.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/utils/adaptive.dart';
import 'package:indar_deco/core/utils/svg.dart';
import 'package:indar_deco/domain/entities/supplier.dart';
import 'package:indar_deco/presentation/controllers/settings_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/text/suppplier_ritch_text.dart';

class SupplierCard extends StatelessWidget {
  final Supplier supplier;
  final int proucts;
  const SupplierCard({super.key,required this.supplier,required this.proucts});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();
    return Container(
      height: 170.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
         boxShadow:const [
      BoxShadow(
        color: AppColors.lightShadow,
        spreadRadius: 1,
        blurRadius: 8,
        offset: Offset(0, 4), // changes position of shadow
      ),
    ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [        Image.network(supplier.image,width: 100.w,fit: BoxFit.cover,),SizedBox(width: 5.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SupplierRitchText(icon:const Icon(Icons.location_on_outlined,size: 18,), text: supplier.address,),
            SupplierRitchText(icon:const Icon(Icons.phone_outlined,size: 18,), text: supplier.phone,),
            SupplierRitchText(icon:const Icon(Icons.email_outlined,size: 18,), text: supplier.email,),
            supplier.webSite==null?Container(): SupplierRitchText(icon:const Icon(Icons.language,size: 18,), text: supplier.webSite??'',),
            SupplierRitchText(icon:Padding(
              padding: Adaptivity.paddingLeft(settingsController.currentlocale, 2),
              child: SvgPicture.string(APPSVG.productIcon,color: AppColors.black,),
            ), text: PluralStrings.numberOfItems(proucts, context),),

          ],)
      ],
        ),
      ),
    );
  }
}