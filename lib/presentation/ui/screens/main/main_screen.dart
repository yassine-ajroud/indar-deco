import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indar_deco/presentation/controllers/main_screen_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/nav_bar/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
      init: MainScreenController(),
      builder: (mainScreenController) {
        return Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    bottomNavigationBar:const BottomNavBar() ,
              body:
                 SafeArea(child: mainScreenController.screens[mainScreenController.selectedScreen]),
    
            );
      }
    );
  }
}