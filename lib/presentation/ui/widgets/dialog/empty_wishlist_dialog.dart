import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';

class EmptyWishlistDialog extends StatelessWidget {
  const EmptyWishlistDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: AppColors.white,
      title: Text(AppLocalizations.of(context)!.arr_session_promblem_title,style:  AppTextStyle.smallBlackTitleTextStyle,),
      content: Text(AppLocalizations.of(context)!.arr_session_promblem_text,style: AppTextStyle.descriptionTextStyle),

    );
  }
}