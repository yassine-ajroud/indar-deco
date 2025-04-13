import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateParser{
  static String getDateDifference(DateTime fromDate,BuildContext context){
    String res='';
  DateTime time = DateTime.timestamp();
  print(time.difference(fromDate).inDays);
 if (time.difference(fromDate).inMinutes > 60) {
    if (time.difference(fromDate).inHours > 24) {
      if (time.difference(fromDate).inDays > 7) {
        res=time.difference(fromDate).inDays.toString();
        if(time.difference(fromDate).inDays < 30) {
                 res='${time.difference(fromDate).inDays ~/ 7} ${AppLocalizations.of(context)!.week}';

        }else{
           if(time.difference(fromDate).inDays < 365) {
                  res='${time.difference(fromDate).inDays ~/ 30} ${AppLocalizations.of(context)!.month}';

        }else{
           res='${time.difference(fromDate).inDays ~/ 365} ${AppLocalizations.of(context)!.year}';
        }
        }     
      } else {
        res='${time.difference(fromDate).inDays} ${AppLocalizations.of(context)!.day}';
      }
    } else {
      res='${time.difference(fromDate).inHours} ${AppLocalizations.of(context)!.hour}';
    }
  } else {
    res='${time.difference(fromDate).inMinutes} ${AppLocalizations.of(context)!.minute}';
  }
    return res;
  }
}