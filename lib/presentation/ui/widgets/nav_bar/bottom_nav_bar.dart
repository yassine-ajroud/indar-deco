import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/utils/svg.dart';
import 'package:indar_deco/presentation/controllers/wishlist_controller.dart';
import 'package:indar_deco/presentation/ui/screens/AR/ar_objects_screen.dart';
import 'package:indar_deco/presentation/ui/widgets/dialog/empty_wishlist_dialog.dart';
import 'package:indar_deco/presentation/ui/widgets/nav_bar/nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
   final WishListController wishListController=Get.find();
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 70,
          decoration:const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight: Radius.circular(25)),
              boxShadow: [
      BoxShadow(
        color: AppColors.lightShadow,
        spreadRadius: 1,
        blurRadius: 8,
        offset: Offset(0, -3), // changes position of shadow
      ),
    ],
          ),        
          ),

     Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //mainAxisSize: MainAxisSize.max,
      children: [
       const NavBarItem(icon: APPSVG.homeIcon, index: 0),
       const NavBarItem(icon: APPSVG.categoryIcon, index: 1),
       SizedBox(width: 25, child: FittedBox(child: InkWell(
          onTap: (){
                        if(wishListController.wishlistModel.isEmpty){
                          showDialog(context: context, builder: (_)=>const EmptyWishlistDialog());
                        }else{
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> ObjectGesturesWidget(models: wishListController.wishlistModel,)));
                        }
                      },
        // ignore: deprecated_member_use
        child: SvgPicture.string(APPSVG.arIcon,color: AppColors.black,)))),
       const NavBarItem(icon: APPSVG.favourite, index: 2),
       const NavBarItem(icon: APPSVG.userIcon, index: 3,),
      ],
    ),
      ],
    );
  }
}