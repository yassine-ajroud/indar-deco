import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/utils/enums.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/di.dart';
import 'package:indar_deco/domain/entities/reclamation.dart';
import 'package:indar_deco/domain/usecases/reclamation_usecases/add_reclamation_usecase.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/cart_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentController extends GetxController{
   String adres='';
   String gov='';
   String ville='';
   String code='';
   String phone='';
   String month='1';
   String year='2024';
   PaymentMethod paymentMethod=PaymentMethod.cash;

void setMonth(String m){
  month = m;
  update();
}
void setYear(String y){
  year = y;
  update();
}
  void getUserAddress(String address,String gouvernorat,String ville,String code,String phone,){
    adres=address;
    gov=gouvernorat;
    ville=ville;
    code=code;
    phone=phone;
  }

  void setPaymentMethod(PaymentMethod method){
    paymentMethod=method;
    update([ControllerID.PAYMENT_METHOD]);
  }

  Future<bool> createOrder(BuildContext context)async{
    bool success=false;
    final AuthenticationController authenticationController=Get.find();
    final CartController cartController=Get.find();
    final s= await verifyOrderItems();
    if(s.isEmpty){
      Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.all_products_out_of_stock,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.black,
            textColor: AppColors.white,
            fontSize: 16.0);
      return false;
    }
    final res = await AddReclamationsUsecase(sl())(Reclamation(user: authenticationController.currentUser.id!, sales: s, reference: generateReference(11), price: cartController.totalPrice,
    address: '$gov-$adres$ville$code'
    ));
    res.fold((l) => null, (r)async {
      await cartController.clearCart();
      success=true;
    });
    return success;
  }

  String generateReference(int length) {
  const String charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  Random random = Random();
  String ref = '';

  for (int i = 0; i < length; i++) {
    int randomIndex = random.nextInt(charset.length);
    ref += charset[randomIndex];
  }

  return ref;
}
bool validCardNumber(String number){
  for(int i=0;i<number.length;i++){
    if(!"0123456789".contains(number[i])){
      return false;
    }
  }
  return true;
}

Future<List<String>> verifyOrderItems()async{
  final CartController cartController = Get.find();
  final AuthenticationController authenticationController = Get.find();

    await cartController.getUserCart(authenticationController.currentUser.id!);
    final exisProd= cartController.cartSales.where((element) => element.quantity>0);
    print(exisProd);
    return exisProd.map((e) => e.id!).toList();
}
}