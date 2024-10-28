import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/adaptive.dart';
import 'package:indar_deco/core/utils/svg.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/ui/screens/authentication/forget_password_screen.dart';
import 'package:indar_deco/presentation/ui/screens/authentication/signup_screen.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/social_media_button.dart';
import 'package:indar_deco/presentation/ui/widgets/text_fields/input.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    myController1.dispose();
    myController2.dispose();
  }

  @override
  void initState() {
    // settingsController = Get.find();
    // splashController = Get.find();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
                backgroundColor: AppColors.white,

      automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<AuthenticationController>(
            init: AuthenticationController(),
            builder:(controller)=> controller.isLoading?const Center(child: CircularProgressIndicator(),) :Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          
                          Text(
                              style: AppTextStyle.titleTextStyle,
                              AppLocalizations.of(context)!.login),
                         const  SizedBox(
                            height: 35,
                          ),
                          InputText(
                            hint: AppLocalizations.of(context)!.email,
                            type: TextInputType.emailAddress,
                            controler: myController1,
                            validator: (v){
                              if(!v!.endsWith("@gmail.com")|| v.isEmpty){
                                return AppLocalizations.of(context)!.invalid_email_address;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          InputText(
                              hint: AppLocalizations.of(context)!.password,
                              //leading: APPSVG.lockIcon,
                              isPassword: true,
                              controler: myController2,
                              validator: (v){
                                 if(v!.length<8 || v.isEmpty){
                                return AppLocalizations.of(context)!.invalid_password;
                              }
                              return null;
                              },
                              ),
                            
                          Align(
                            alignment: Adaptivity.alignmentRight('Fr'),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const ForgetPasswordScreen()));
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.forgot_password,
                                 style: AppTextStyle.lightLabelTextStyle,
                                )),
                          ),
                           const SizedBox(
                            height: 25,
                          ),
                         PrimaryButton(
                              text: AppLocalizations.of(context)!.login,
                              click: () async{
                               if( _formKey.currentState!.validate()){
                               // SplashController splashController=Get.find();
                                  await controller.login(myController1, myController2,context);
                               }
                                
                              },
                            ),
                     
     const      SizedBox(
                            height: 35,
                          ),

 Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                           const Expanded(child: Divider(color: AppColors.grey,thickness: 1,endIndent: 20,indent: 0,)),
                            Text(AppLocalizations.of(context)!.or_continue_with,style: AppTextStyle.lightLabelTextStyle,),
                              const Expanded(child: Divider(color: AppColors.grey,thickness: 1,endIndent: 0,indent: 20,)),

                          ],),  const SizedBox(
                            height: 35,
                          ),
                          
                           SocialSecondaryButton(text: AppLocalizations.of(context)!.continue_with_facebook, onClick: () async{
                                  await controller.facebookLogin(context);
                                  }, asset: APPSVG.facebookIcon),
                                  const  SizedBox(height: 15,),
                                 SocialSecondaryButton(text: AppLocalizations.of(context)!.continue_with_google, onClick: ()async {
                                      await controller.googleLogin(context);
                           
                                 }, asset: APPSVG.googleIcon),
                             const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(AppLocalizations.of(context)!.dont_have_account,
                                  textAlign: TextAlign.center,style: AppTextStyle.lightLabelTextStyle,),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) =>const SignupScreen()));
                                },
                                child:  Text(
                                  AppLocalizations.of(context)!.signUp,
                                  style:AppTextStyle.blueTextStyle,
                                ),
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}