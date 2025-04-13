import 'package:flutter/material.dart';
import 'package:indar_deco/core/styles/text_styles.dart';

class StepItem {
  static Step makeStep(
      {
        required StepState state, 
        required bool isActive,
      required String title,
      required String date,}) {
    return Step(
      state: state,
        isActive:isActive,
        title: Text(title,style: AppTextStyle.blackTextStyle,),
        content: const SizedBox(),
        subtitle: Text(date,style: AppTextStyle.smallGreyTextStyle,)
        );
  }
}
