import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/presentation/controllers/main_screen_controller.dart';

class NavBarItem extends StatelessWidget {
  final String icon;
  final int index;
  const NavBarItem({super.key,required this.icon,required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  MainScreenController(),
      builder: (controller) {
        return InkWell(
          onTap: (){
            controller.selectScreen(index);
          },          
          child:  SvgPicture.string(icon,color: index==controller.selectedScreen?AppColors.primary:AppColors.black,),
        );
      }
    );
  }
}