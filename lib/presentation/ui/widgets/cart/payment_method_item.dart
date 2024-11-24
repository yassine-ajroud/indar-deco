import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/enums.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/presentation/controllers/payment_controller.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentMethod method;
  final String icon;
  final String label;
  const PaymentMethodItem({super.key,required this.method,required this.icon,required this.label});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: ControllerID.PAYMENT_METHOD,
      init: PaymentController(),
      builder: (controller) {
        return Row(
          children: [
            Radio<PaymentMethod>(
              activeColor: AppColors.secondary,
              value: method, groupValue: controller.paymentMethod, onChanged: (v){
              controller.setPaymentMethod(method);
            }),
                         const SizedBox(width: 10,),

             SvgPicture.string(icon),
             const SizedBox(width: 10,),
             Text(label,style: AppTextStyle.blackTextStyle,)
          ],
        );
      }
    );
  }
}