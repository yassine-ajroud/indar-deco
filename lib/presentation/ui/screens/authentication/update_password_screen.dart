import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/settings_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:indar_deco/presentation/ui/widgets/text_fields/input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';


class UpdatePasswordScreen extends StatefulWidget {
   const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
    final _formKey = GlobalKey<FormState>();
  final currentPassword = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();
  final recovery = TextEditingController();
  final SettingsController settingsController = Get.find();
  final AuthenticationController authenticationController = Get.find();

@override
  void dispose() {
    currentPassword.dispose();
    password.dispose();
    cpassword.dispose();
    recovery.dispose();
    super.dispose();
  }

  @override
  void initState() {
    recovery.text = authenticationController.currentUser.recoveryEmail??'';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: true,

      ),
      body: GetBuilder<AuthenticationController>(
        init: AuthenticationController(),
        builder: (controller) {
          print('my user ${controller.currentUser}');
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        style: AppTextStyle.titleTextStyle,
                        AppLocalizations.of(context)!.confidentiality),
                                      const SizedBox(
                      height: 40,
                    ),
                     InputText(
                      hint: AppLocalizations.of(context)!.current_password,
                      controler: currentPassword,
                      isPassword: true,
                            validator: (v){
                               if(v!.length<8 || v.isEmpty){
                              return AppLocalizations.of(context)!.invalid_password;
                            }
                            return null;
                            },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputText(
                      hint: AppLocalizations.of(context)!.password,
                      controler: password,
                       isPassword: true,
                            validator: (v){
                               if(v!.length<8 || v.isEmpty){
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
                        type: TextInputType.text,
                        controler: cpassword,
                         isPassword: true,
                            validator: (v){
                               if(v!.isEmpty || v!=password.text){
                              return AppLocalizations.of(context)!.password_does_not_match;
                            }
                            return null;
                          
                        }),
                             const SizedBox(
                      height: 20,
                    ),
                    InputText(
                      controler: recovery,
                        hint: AppLocalizations.of(context)!.recovery_email,
                        type: TextInputType.emailAddress,
                            validator: (v){
                               if(v!.isEmpty || !v.contains('@gmail.com')){
                              return AppLocalizations.of(context)!.invalid_email_address;
                            }
                            return null;
                          
                        }),
                     const SizedBox(height:40),
                        PrimaryButton(text: AppLocalizations.of(context)!.save, click: ()async{
                          if(_formKey.currentState!.validate()){
                                await controller.updatePassword(currentPassword, password, cpassword, recovery,context);
                          }
                        })
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
