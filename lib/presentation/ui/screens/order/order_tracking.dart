import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/core/l10n/plural_strings.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/presentation/controllers/order_tracking_controller.dart';
import 'package:indar_deco/presentation/controllers/reclamations_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/order/sale_item.dart';
import 'package:indar_deco/presentation/ui/widgets/order/step_item.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final RaclamationsController reclamations= Get.find();
    return GetBuilder(
      init: OrderTrackingController(),
      builder:(c)=> Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.bgColor,
          automaticallyImplyLeading: true,
          title: Text(AppLocalizations.of(context)!.order_tracking,
              style:  AppTextStyle.appBarTextStyle),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future:c.getSales(reclamations.currentReclamation) ,
          builder:(ctx,snapshot){
            if(snapshot.hasData){
              return Padding(
            padding: EdgeInsets.all(18.0.r),
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.order_items,
                            style: AppTextStyle.subTitleTextStyle,
                          ),
                          Text(
                            PluralStrings.numberOfItems(c.salesList.length,
                                context), 
                            style: AppTextStyle.smallBlackTextStyle,
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: c.salesList.map((e)=>InkWell(
                            onTap: (){c.selecteSale(c.salesList.indexOf(e));c.changeSale(c.products.firstWhere((element) => e.productId==element.id).id!);},
                            child: SaleItem(product: c.products.firstWhere((element) => e.productId==element.id), sale: e,isSelected: c.salesList.indexOf(e)==c.selected,))).toList()
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.track_package,
                        style: AppTextStyle.subTitleTextStyle,
                      ),
                      Stepper(
                          currentStep:c.getCurrentStep(c.salesList[c.selected]),
                          onStepContinue: null,
                          onStepCancel: null,
                          onStepTapped: null,
                          controlsBuilder: (context, details) => Container(),
                          steps: [
                            StepItem.makeStep(
                              isActive: c.salesList[c.selected].status![0].date!=null,
                                title: AppLocalizations.of(context)!
                                    .order_confirmation,
                                date: c.salesList[c.selected].status![0].date??"",
                                state:  c.salesList[c.selected].status!.isNotEmpty?StepState.complete:StepState.indexed),
                            StepItem.makeStep(
                               isActive:   c.salesList[c.selected].status![1].date!=null,
                                title:
                                    AppLocalizations.of(context)!.ongoing_treatment,
                                date: c.salesList[c.selected].status![1].date??"",
                                state:c.getCurrentStep(c.salesList[c.selected])>=1?StepState.complete:StepState.indexed),
                            StepItem.makeStep(
                               isActive:  c.salesList[c.selected].status![2].date!=null,
                                title: AppLocalizations.of(context)!.in_preparation,
                                date: c.salesList[c.selected].status![2].date??"",
                               state:  c.getCurrentStep(c.salesList[c.selected])>2?StepState.complete:StepState.indexed),
                            StepItem.makeStep(
                               isActive:  c.salesList[c.selected].status![3].date!=null,
                                title: AppLocalizations.of(context)!.shipping,
                                date: c.salesList[c.selected].status![3].date??"",
                               state: c.getCurrentStep(c.salesList[c.selected])>=3?StepState.complete:StepState.indexed),
                            // StepItem.makeStep(
                            //    isActive:  c.salesList[c.selected].status![4].date!=null,
                            //     title: AppLocalizations.of(context)!.delivery,
                            //     location: '',
                            //     date: "",
                            //    state:  c.salesList[c.selected].status!.length>=4?StepState.complete:StepState.indexed)
                          ])
                    ]),
              ),
            ),
          );
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }else{
              return const Center(child: Text('error'),);
            }
          } 
        ),
      ),
    );
  }
}
