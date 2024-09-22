import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:indar_deco/presentation/ui/screens/authentication/profile_screen.dart';
import 'package:indar_deco/presentation/ui/screens/main/category_screen.dart';
import 'package:indar_deco/presentation/ui/screens/main/home_screen.dart';
import 'package:indar_deco/presentation/ui/screens/main/wishlist_screen.dart';


class MainScreenController extends GetxController{
  int selectedScreen=0;
  List<Widget> screens=[const HomeScreen(),const CategoryScreen(),const WishListScreen(),const ProfileScreen()];
  double homeScrollPosition=0.0;

  ScrollController scrollcontrollerA = ScrollController(keepScrollOffset: true);

  void selectScreen(int index){
    selectedScreen=index;
    update();
  }
}