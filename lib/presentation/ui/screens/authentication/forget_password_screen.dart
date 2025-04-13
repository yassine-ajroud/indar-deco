import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/settings_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:indar_deco/presentation/ui/widgets/dialog/recovery_email_dialog.dart';
import 'package:indar_deco/presentation/ui/widgets/text_fields/input.dart';
import '../../../../core/styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();

@override
  void dispose() {
    super.dispose();
    email.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
                backgroundColor: AppColors.white,
      actions: [GetBuilder(
        init: SettingsController(),
        builder: (c) {
          return PopupMenuButton(itemBuilder: (_)=>[
            PopupMenuItem(value: 'en',child: Text(AppLocalizations.of(context)!.en),),
             PopupMenuItem(value: 'fr',child: Text(AppLocalizations.of(context)!.fr),),
              PopupMenuItem(value: 'ar',child: Text(AppLocalizations.of(context)!.ar),)
          ],child:const  Padding(
            padding:  EdgeInsets.symmetric(horizontal :10.0),
            child:  Icon(Icons.translate),
          ),
          onSelected: (v)async{
            // c.setLocal(v);
            await c.saveLocale(v);
            await c.loadLocale();
          },
          );
        }
      )],
      automaticallyImplyLeading: true,
      ), 
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    style: AppTextStyle.titleTextStyle, AppLocalizations.of(context)!.forgot_password2),
                const SizedBox(
                  height: 30,
                ),
                
                Form(
                    key: _formKey,
                    child: InputText(
                      hint: AppLocalizations.of(context)!.email,
                      type: TextInputType.emailAddress,
                      controler: email,
                      validator: (v) {
                        if (!v!.endsWith("@gmail.com") || v.isEmpty) {
                          return AppLocalizations.of(context)!
                              .invalid_email_address;
                        }
                        return null;
                      },
                    )),
                    
                const SizedBox(
                  height: 40,
                ),  Text(
                      style: AppTextStyle.darkLabelTextStyle, AppLocalizations.of(context)!.enter_email_address),
                       const SizedBox(
                  height: 10,
                ),
                 Text(
                      style: AppTextStyle.descriptionTextStyle, AppLocalizations.of(context)!.verification_code_details,textAlign: TextAlign.center,),
                      const SizedBox(
                  height: 40,
                ),
                GetBuilder<AuthenticationController>(
                  init: AuthenticationController(),
                  builder: (controller) {
                    return PrimaryButton(
                      text: AppLocalizations.of(context)!.send,
                      click: () async{
                        if (_formKey.currentState!.validate()) {
                          final recovery= await controller.getRecoveryEmail(email.text);
                          if(recovery==null){
                            // ignore: use_build_context_synchronously
                            await  controller.sendFrogetPasswordRequest(email,email.text, context);
                          }else{
                               // ignore: use_build_context_synchronously
                               showDialog(context: context,builder: (_)=> RecoveryEmailDialog(email: email.text,recoveryEmail: recovery,),  barrierDismissible: false,);

                          }
                        }
                      },
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }
}


