import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecoveryEmailDialog extends StatefulWidget {
  final String email;
  final String recoveryEmail;
  const RecoveryEmailDialog({super.key,required this.email,required this.recoveryEmail});

  @override
  State<RecoveryEmailDialog> createState() => _RecoveryEmailDialogState();
}

class _RecoveryEmailDialogState extends State<RecoveryEmailDialog> {
  late String dest;
  late AuthenticationController authenticationController;

  @override
  void initState() {
   dest=widget.email;
   authenticationController = Get.find();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.send_OTP_to),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
        Row(
          children: [
            Radio(value: widget.email, groupValue: dest, onChanged: (v){
              setState(() {
                dest=v!;
              });
            }),
            SizedBox(width: 200.w, child: Text(widget.email,style: AppTextStyle.blackTextStyle,))
          ],
        ),
        Row(
          children: [
            Radio(value: widget.recoveryEmail, groupValue: dest, onChanged: (v){
              setState(() {
                dest=v!;
              });
            }),
            SizedBox(width: 210.w, child: Text(widget.recoveryEmail,style: AppTextStyle.blackTextStyle,))
          ],
        )
      ],),
      actions: [Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: PrimaryButton(text: AppLocalizations.of(context)!.send, click: ()async{
                                      await  authenticationController.sendFrogetPasswordRequest(TextEditingController.fromValue(TextEditingValue(text:widget.email!)),dest, context);

        }),
      )],
    );
  }
}