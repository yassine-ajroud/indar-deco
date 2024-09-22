
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/ui/screens/authentication/sign_in_screen.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';
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
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
      ) ,
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
                          height: 40,
                        ),
                  GetBuilder<AuthenticationController>(
                    init: AuthenticationController(),
                    builder: (controller) {
                      return PrimaryButton(
                        text: AppLocalizations.of(context)!.registration,
                        click: () async {
                          if (_formKey.currentState!.validate()) {

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
