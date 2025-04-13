
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/core/styles/text_styles.dart';


class BetaDialog extends StatelessWidget {
  const BetaDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
  title:  Text(AppLocalizations.of(context)!.feature_unavailable,style:AppTextStyle.smallBlackTitleTextStyle,),
  backgroundColor: Colors.white,
  // shape:const  RoundedRectangleBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(20))
  // ),
  content:  Text(AppLocalizations.of(context)!.feature_unavailable_text,style:  AppTextStyle.descriptionTextStyle,),
);
  }
}