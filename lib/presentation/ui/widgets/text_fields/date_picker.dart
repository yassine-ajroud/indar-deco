import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';


class DatePickerInput extends StatefulWidget {
  const DatePickerInput({super.key});

  @override
  State<DatePickerInput> createState() => _DatePickerInputState();
}

class _DatePickerInputState extends State<DatePickerInput> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      init: AuthenticationController(),
      builder: (controller) {
        return Container(
          height: 45.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(bottom: BorderSide(width: 0.8,color: AppColors.black)),
 
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(controller.birthDate?? AppLocalizations.of(context)!.birth_date,style: controller.birthDate==null? AppTextStyle.hintTextStyle:AppTextStyle.normalTextStyle,),
              ),

              IconButton(
             onPressed: ()async{
               
                  final now = DateTime.now();
             final date = await showDatePicker(context: context, initialDate: now, firstDate: DateTime(1900), lastDate: DateTime(now.year+10));
              if(date!=null){
              controller.setBirthDate(date);
        
              }
                
             },icon: const Icon(Icons.calendar_month_outlined),
             )
            ],
          ),
        );
      }
    );
  }
}