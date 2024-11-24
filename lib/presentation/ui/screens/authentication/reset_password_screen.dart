import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/settings_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:indar_deco/presentation/ui/widgets/text_fields/input.dart';
import '../../../../core/styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final newPassword = TextEditingController();
  final newPasswordconfirm = TextEditingController();

  @override
  void dispose() {
    newPassword.clear();
    newPasswordconfirm.clear();
    super.dispose();
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
                    style: AppTextStyle.titleTextStyle,
                    AppLocalizations.of(context)!.reset_password),
        
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputText(
                                  hint: AppLocalizations.of(context)!.password,
                                  isPassword: true,
                                  controler: newPassword,
                                  validator: (v){
                                     if(v!.length<8){
                                    return AppLocalizations.of(context)!.invalid_password;
                                  }
                                  return null;
                                  },
                                  
                        ),
          const SizedBox(
                  height: 20,
                ),
                        InputText(
                              hint: AppLocalizations.of(context)!.confirm_password,
                              isPassword: true,
                              controler: newPasswordconfirm,
                              validator: (v){
                                 if(v!.length<8 || v!=newPassword.text){
                                return AppLocalizations.of(context)!.invalid_password;
                              }
                              return null;
                              },
                              ),
                      ],
                    )),
                const SizedBox(
                  height: 40,
                ),
               GetBuilder<AuthenticationController>(
                 init: AuthenticationController(),
                 builder: (controller) {
                   return PrimaryButton(
                                       text: AppLocalizations.of(context)!.reset,
                                       click: () async{
                                         if (_formKey.currentState!.validate()) {
                                         await  controller.resetPassword(newPassword, newPasswordconfirm, context);
                                         }
                                       },
                                     ); 
                 },
               )
              ]),
        ),
      ),
    );
  }
}
