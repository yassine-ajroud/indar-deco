import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/svg.dart';
import 'package:indar_deco/presentation/controllers/cart_controller.dart';
import 'package:indar_deco/presentation/ui/screens/main/cart_screen.dart';
import 'package:indar_deco/presentation/ui/widgets/text_fields/search_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainSliverAppBar extends StatelessWidget {
  final String title;
  final void Function(String?)? onChanged;
  final TextEditingController? textEditingController;
  const MainSliverAppBar(
      {super.key,
      required this.title,
      required this.onChanged,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        centerTitle: true,
        title: Text(
          title,
          style: AppTextStyle.appBarTextStyle,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.string(APPSVG.notificationIcon)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CartScreen()));
              },
              icon: Stack(
                children: [
                  SvgPicture.string(APPSVG.cartIcon),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GetBuilder(
                      init: CartController(),
                      builder: (cartController) {
                        return cartController.currentCart.productsId.isEmpty?Container() : CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: 7,
                          child: Text(
                            cartController.currentCart.productsId.length.toString(),
                            style: AppTextStyle.cartBadgeTextTextStyle,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ))
        ],
        expandedHeight: 150.h,
        elevation: 4,
        snap: true,
        pinned: true,
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SearchInput(
                  hint: AppLocalizations.of(context)!.search,
                  onChanged: onChanged,
                  controler: textEditingController,
                ),
              )),
        ));
  }
}
