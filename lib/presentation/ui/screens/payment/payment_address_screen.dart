import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/payment_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:indar_deco/presentation/ui/widgets/text_fields/input.dart';

import 'payment_method_screen.dart';

class PaymentAddressScreen extends StatefulWidget {
  const PaymentAddressScreen({super.key});

  @override
  State<PaymentAddressScreen> createState() => _PaymentAddressScreenState();
}
late  TextEditingController address;
late  TextEditingController gov;
late  TextEditingController ville;
late  TextEditingController code;
late  TextEditingController phone;

  final _formKey = GlobalKey<FormState>();

class _PaymentAddressScreenState extends State<PaymentAddressScreen> {
@override
  void initState() {
    AuthenticationController authenticationController=Get.find();
    address=TextEditingController();
    gov=TextEditingController();
    gov.text=authenticationController.currentUser.address??"";
    ville=TextEditingController();
    code=TextEditingController();
    phone=TextEditingController();
    phone.text=authenticationController.currentUser.phone??'';
    super.initState();
  }

  @override
  void dispose() {
    address.dispose();
    gov.dispose();
    ville.dispose();
    code.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: true,

      ),
      backgroundColor: AppColors.white,
      body: GetBuilder(
        init: PaymentController(),
        builder: (controller) {
          return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Form(
                                key:_formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                        Text(
                                                        style: AppTextStyle.titleTextStyle,
                                                        AppLocalizations.of(context)!.delivery_address,),
                                                                    const SizedBox(height:40),
                                
                                      InputText(hint: AppLocalizations.of(context)!.address,controler: address,validator: (v){
                                        if(v!.isEmpty){
                                          return AppLocalizations.of(context)!.address_required;
                                        }
                                        return null;
                                      },),
                                      const SizedBox(height:20),
                                      InputText(hint: AppLocalizations.of(context)!.city,controler: gov,
                                      validator: (v){
                                        if(v!.isEmpty){
                                         return AppLocalizations.of(context)!.required_city;
                                        }
                                        return null;
                                      },),
                                      const SizedBox(height:20),
                                      InputText(hint:  AppLocalizations.of(context)!.ville,controler: ville,
                                       validator: (v){
                                        if(v!.isEmpty){
                                         return AppLocalizations.of(context)!.required_ville;
                                        }
                                        return null;
                                      },),
                                        const SizedBox(height:20),
                                      InputText(hint: AppLocalizations.of(context)!.postal_code,type: TextInputType.number,length: 4,controler: code,
                                       validator: (v){
                                        if(v!.length!=4){
                                          return AppLocalizations.of(context)!.required_postal_code;
                                        }
                                        return null;
                                      },),
                                        const SizedBox(height:20),
                                      InputText(hint: AppLocalizations.of(context)!.phone_number,type: TextInputType.number,length: 8,controler: phone,
                                       validator: (v){
                                        if(v!.isEmpty){
                                          return AppLocalizations.of(context)!.phone_number;
                                        }
                                        return null;
                                      },),
                                            const SizedBox(height:40),
                                          PrimaryButton(text: AppLocalizations.of(context)!.next, click: (){
                                             if(_formKey.currentState!.validate()){
                                             controller.getUserAddress(address.text, gov.text, ville.text, code.text, phone.text);
                                             Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const PaymentMethodScreen()));
                                            }
                                       })
                                
                                    ],
                                  ),
                                ),
                              ),
                            )
          ;
        }
      ),
    );
  }
}