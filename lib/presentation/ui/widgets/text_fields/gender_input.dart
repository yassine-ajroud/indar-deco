import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';


class GenderInput extends StatefulWidget {
  const GenderInput({super.key});

  @override
  State<GenderInput> createState() => _GenderInputState();

}

class _GenderInputState extends State<GenderInput> {
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<AuthenticationController>(
      init: AuthenticationController(),
      builder: (controller) {
        return DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
                                    padding: const EdgeInsets.symmetric(horizontal: 0.0),

         decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder() ,
                    filled: true,
                    hintText: AppLocalizations.of(context)!.gender,
                    fillColor:AppColors.white,
                    ),
                  isExpanded: true,
                  value: controller.gender,
                  hint: Text(
                    AppLocalizations.of(context)!.gender,
                  ),
                  onChanged: (value) {
                    controller.setGender(value!);
                  },
                  items: [
            DropdownMenuItem<String>(value: 'male',child: Text(AppLocalizations.of(context)!.male),),
            DropdownMenuItem<String>(value: 'female',child: Text(AppLocalizations.of(context)!.female),)


          ],
                
                ),
          );
      }
    );
  }
}