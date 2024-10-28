import 'package:flutter/material.dart';
import 'package:indar_deco/core/styles/text_styles.dart';

class SupplierRitchText extends StatelessWidget {
  final Widget icon;
  final String text;
  const SupplierRitchText({super.key, required this.icon,required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: 220,
        child: Text.rich(TextSpan(children: [WidgetSpan(child: icon),const WidgetSpan(child: SizedBox(width: 4,)),TextSpan(text: text,style: AppTextStyle.smallBlackTextStyle)]))),
    );
  }
}