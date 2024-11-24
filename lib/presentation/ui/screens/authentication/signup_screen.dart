
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/settings_controller.dart';
import 'package:indar_deco/presentation/ui/screens/authentication/sign_in_screen.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:indar_deco/presentation/ui/widgets/dialog/terms_conditions.dart';
import 'package:indar_deco/presentation/ui/widgets/text_fields/input.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

    @override
  void dispose() {
    super.dispose();
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    password.dispose();
    cpassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
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
      automaticallyImplyLeading: false,
      ), 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      style: AppTextStyle.titleTextStyle,
                      AppLocalizations.of(context)!.create_your_account),
                const  SizedBox(
                          height: 30,
                        ),
                  InputText(
                    hint: AppLocalizations.of(context)!.first_name,
                    controler: firstname,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .first_name_required;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                          height: 25,
                        ),
                  InputText(
                    hint: AppLocalizations.of(context)!.last_name,
                    controler: lastname,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .last_name_required;
                      }
                      return null;
                    },
                  ),
                 const SizedBox(
                          height: 25,
                        ),
                  InputText(
                      hint: AppLocalizations.of(context)!.email,
                      type: TextInputType.emailAddress,
                      controler: email,
                      validator: (v) {
                        if (!v!.endsWith('@gmail.com') || v.isEmpty) {
                          return AppLocalizations.of(context)!
                              .invalid_email_address;
                        }
                        return null;
                      }),
                  const SizedBox(
                          height: 25,
                        ),
                  InputText(
                      hint: AppLocalizations.of(context)!.password,
                      isPassword: true,
                      controler: password,
                      validator: (v) {
                        if (v!.length < 8) {
                          return AppLocalizations.of(context)!
                              .invalid_password;
                        }
                        return null;
                      }),
                 const  SizedBox(
                          height: 25,
                        ),
                  InputText(
                      hint: AppLocalizations.of(context)!.confirm_password,
                      isPassword: true,
                      controler: cpassword,
                      validator: (v) {
                        if (v != password.text || v!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .password_does_not_match;
                        }
                        return null;
                      }),
                      const SizedBox(
                          height: 5,
                        ),
                       SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GetBuilder<AuthenticationController>(
                            id: ControllerID.TERMS_AND_CONDITIONS,
                              init: AuthenticationController(),
                              builder: (controller) {
                                return Checkbox(
                                  activeColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  value: controller.termsAccepted,
                                  onChanged: (value) {
                                    controller.aceptTerms(value!);
                                  },
                                );
                              },
                            ),
                            Expanded(
                              child: Text.rich(
                                TextSpan(children:[ TextSpan(text:AppLocalizations.of(context)!.i_accept,style:AppTextStyle.smallBlackTextStyle),
                              WidgetSpan(alignment:PlaceholderAlignment.middle, child:GestureDetector(
                                onTap: (){
                                  showDialog(context: context, builder: (_)=>const TermsAndConditionsDialog());
                                },
                                child: Text( AppLocalizations.of(context)!.terms_and_conditions,style: AppTextStyle.smallBlackTextStyle.copyWith(fontWeight: FontWeight.bold) ))),]),overflow: TextOverflow.visible,),
                            ),
                          ],
                        ),
                      ),
                   const SizedBox(
                          height: 25,
                        ),
                  GetBuilder<AuthenticationController>(
                    init: AuthenticationController(),
                    builder: (controller) {
                      return PrimaryButton(
                        text: AppLocalizations.of(context)!.registration,
                        click: () async {
                          if (_formKey.currentState!.validate()&&controller.termsAccepted) {

                             await controller.createAccount(
                                cpassword: cpassword,
                                email: email,
                                firstName: firstname,
                                lastName: lastname,
                                password: password,
                                context: context);
                              }else{
                                Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!.missing_data,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColors.toastColor,
                      textColor: AppColors.white,
                      fontSize: 16.0);
                                          
                          }
                        },
                      );
                    },
                  ),
                   const SizedBox(
                          height: 25,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(AppLocalizations.of(context)!.connect_to_your_account,
                          textAlign: TextAlign.center,style: AppTextStyle.lightLabelTextStyle,),
                      TextButton(
                        onPressed: () {
                           Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) =>const LoginScreen()));
                        },
                        child:  Text(
                          AppLocalizations.of(context)!.login,
                          style: AppTextStyle.blueTextStyle,
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
