import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/enums.dart';
import 'package:indar_deco/core/utils/svg.dart';
import 'package:indar_deco/presentation/controllers/payment_controller.dart';
import 'package:indar_deco/presentation/ui/screens/main/main_screen.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:indar_deco/presentation/ui/widgets/cart/payment_method_item.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: AppColors.white,
      body:GetBuilder(
        init: PaymentController(),
        builder: (controller) {
          return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Text(
                        style: AppTextStyle.titleTextStyle,
                       AppLocalizations.of(context)!.payment_method),
                                                                  const SizedBox(height:40),
                                    PaymentMethodItem(method: PaymentMethod.cash, icon: APPSVG.cashIcon, label: AppLocalizations.of(context)!.cash_on_delivery),
                                const Padding(
                padding:  EdgeInsets.symmetric(vertical: 10.0),
                child:  Divider(),
              ),
                                    PaymentMethodItem(method: PaymentMethod.digital, icon: APPSVG.payementCard, label: AppLocalizations.of(context)!.online_payment),

                                          const SizedBox(height:60),
                                        PrimaryButton(text: AppLocalizations.of(context)!.next, click: ()async{
                
                                            if(controller.paymentMethod==PaymentMethod.cash){
                                             final res=  await controller.createOrder(context);
                                             if(res){
                                              Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!.order_added,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.toastColor,
                          textColor: AppColors.white,
                          fontSize: 16.0);
                                             }
                                             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const MainScreen()));
                                                                                         
                                            }else{
                                            // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const PaymentOnlineScreen()));

                                            }
                                          
                                     })

                                  ],
                                ),
                              );
        }
      ), 

    );
  }
}

