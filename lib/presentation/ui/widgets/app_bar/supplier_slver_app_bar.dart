import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/domain/entities/supplier.dart';
import 'package:indar_deco/presentation/ui/widgets/supplier/supplier_card.dart';


class SupplierSliverAppBar extends StatelessWidget {
  final Supplier supplier;
  final int products;
  const SupplierSliverAppBar({super.key, required this.supplier,required this.products});

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      centerTitle: true,
      backgroundColor: AppColors.background,
      title: Text( supplier.marque,style: AppTextStyle.appBarTextStyle,),
      elevation: 4,
      snap: true,
      automaticallyImplyLeading: true,
      pinned: true,
      floating: true,
      expandedHeight: 250.h,

     flexibleSpace:  FlexibleSpaceBar(
          background: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:  const EdgeInsets.all(20.0),
                child: SupplierCard(supplier: supplier,proucts:products ,)
              )),
        )
    );
  }
}

 