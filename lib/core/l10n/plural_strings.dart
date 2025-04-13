import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../styles/text_styles.dart';

class PluralStrings {
  static String numberOfItems(int number, BuildContext context) => Intl.plural(
        number,
        one: AppLocalizations.of(context)!.item,
        other: "$number ${AppLocalizations.of(context)!.items}",
        name: "itemsnumber",
        args: [number],
      );

  static Text onOrder(int number, BuildContext context) {
    Text res;
    switch (number) {
      case -1:
        res = Text(AppLocalizations.of(context)!.by_order,style: AppTextStyle.onStockTextStyle);
        break;
      case 0:
        res = Text(AppLocalizations.of(context)!.out_of_stock,style: AppTextStyle.outOfStockTextStyle);
        break;
      default:
        res = Text(AppLocalizations.of(context)!.on_stock,style: AppTextStyle.onStockTextStyle);
        break;
    }
    return res;
  }

    static String ratings(int number, BuildContext context) {
    String res;
    switch (number) {
      case 1:
        res =AppLocalizations.of(context)!.one_rate;
        break;
      case 2:
        res = AppLocalizations.of(context)!.two_rate;
        break;  
      case >1 && <10:
        res ='$number ${AppLocalizations.of(context)!.ratings}';
        break;
        case>9:
            res ='$number ${AppLocalizations.of(context)!.rate}';
        break;
      default:
        res = '$number ${AppLocalizations.of(context)!.rate}';
        break;
    }
    return res;
  }
}
