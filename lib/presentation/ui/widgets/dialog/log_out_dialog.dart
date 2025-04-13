
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';



class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController controller = Get.find();
    return  AlertDialog(
  title:  Text(AppLocalizations.of(context)!.logout_confirm),
   titleTextStyle: const TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: 20),
  backgroundColor: Colors.white,
  shape:const  RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),
  actionsPadding: const EdgeInsets.symmetric(horizontal:20,vertical: 10),
  actions: [
    TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text(AppLocalizations.of(context)!.cancel)),
    SizedBox(
      width: 150.w,
      child: PrimaryButton(text: AppLocalizations.of(context)!.logout, click: ()async{
        await controller.logout(context);
      }),
    )
  ]
);
  }
}