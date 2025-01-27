import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/core/l10n/plural_strings.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/cart_controller.dart';
import 'package:indar_deco/presentation/ui/screens/payment/payment_address_screen.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:indar_deco/presentation/ui/widgets/cart/cart_item.dart';
// ignore: depend_on_referenced_packages
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController = Get.find();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GetBuilder(
          init: CartController(),
          builder: (controller) {
            return FutureBuilder(
                future: controller
                    .getUserCart(authenticationController.currentUser.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: true,
                          backgroundColor: AppColors.background,
                          shadowColor: AppColors.lightShadow,
                          title: Text(
                            AppLocalizations.of(context)!.cart,
                            style: AppTextStyle.appBarTextStyle,
                          ),
                          elevation: 4,
                          snap: true,
                          pinned: true,
                          floating: true,
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 20),
                        ),
                        controller.currentCart.productsId.isNotEmpty
                            ? SliverList.builder(
                                itemCount: controller.cartSales.length,
                                itemBuilder: (_, index) =>
                                    CartItem(sale: controller.cartSales[index]))
                            : SliverToBoxAdapter(
                                child: Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .empty_cart,style: AppTextStyle.blackTextStyle)),
                              ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20),
                            child: Column(children: [
                              Container(
                                decoration: const BoxDecoration(
                                    border: DashedBorder.fromBorderSide(
                                        dashLength: 5,
                                        side: BorderSide(
                                            color: AppColors.lightShadow,
                                            width: 2)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.payment_details} :",
                                            style:
                                                AppTextStyle.boldGreyTextStyle,
                                          ),
                                          Text(
                                            PluralStrings.numberOfItems(
                                                controller.currentCart
                                                    .productsId.length,
                                                context),
                                            style: AppTextStyle.blackTextStyle,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.sub_total} :",
                                            style:
                                                AppTextStyle.smallGreyTextStyle,
                                          ),
                                          GetBuilder(
                                            init: CartController(),
                                            id: ControllerID.SALE_QUANTITY,
                                            builder: (quantityController) {
                                              return Text(
                                                "${(quantityController.totalPrice - quantityController.shipping_fee).toStringAsFixed(3)}${AppLocalizations.of(context)!.dinar}",
                                                style: AppTextStyle
                                                    .smallBlackTextStyle,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.shipping_fee} :",
                                            style:
                                                AppTextStyle.smallGreyTextStyle,
                                          ),
                                          Text(
                                            "${controller.shipping_fee.toStringAsFixed(3)}${AppLocalizations.of(context)!.dinar}",
                                            style: AppTextStyle
                                                .smallBlackTextStyle,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: DashedBorder.fromBorderSide(
                                        dashLength: 5,
                                        side: BorderSide(
                                            color: AppColors.lightShadow,
                                            width: 2)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context)!.total_price} :",
                                        style: AppTextStyle
                                            .smallBlackTitleTextStyle,
                                      ),
                                      GetBuilder(
                                          id: ControllerID.SALE_QUANTITY,
                                          init: CartController(),
                                          builder: (quantityController) {
                                            return Text(
                                              '${(quantityController.totalPrice).toStringAsFixed(3)}${AppLocalizations.of(context)!.dinar}',
                                              style: AppTextStyle
                                                  .blackTitleTextStyle,
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              PrimaryButton(
                                text: AppLocalizations.of(context)!.checkout,
                                click: () {
                                  if(controller.currentCart.productsId.isNotEmpty){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const PaymentAddressScreen()));

                                }
                                },
                                disabled:
                                    controller.currentCart.productsId.isEmpty,
                              )
                            ]),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 90),
                        )
                      ],
                    );
                  } else {
                    return const Text("error");
                  }
                });
          }),
    );
  }
}
