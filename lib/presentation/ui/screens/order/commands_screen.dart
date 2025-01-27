import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/presentation/controllers/reclamations_controller.dart';
import 'package:indar_deco/presentation/ui/screens/order/order_tracking.dart';
import 'package:indar_deco/presentation/ui/widgets/order/command_Item.dart';


class CommandsScreen extends StatelessWidget {
  const CommandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
  Get.put(RaclamationsController);
    return GetBuilder(
      init: RaclamationsController(),
      builder:(c)=> Scaffold(
            backgroundColor: AppColors.background,
            body: 
                   FutureBuilder(
                    future: c.getCommands(),
                    builder: (ctx,snapashot){
                      if(snapashot.hasData){
                        return  CustomScrollView(
                                 slivers: [
                                   SliverAppBar(
                      automaticallyImplyLeading: true,
                      floating: true,
                      pinned: true,
                      snap: true,
                      backgroundColor: AppColors.bgColor,
                      title: Text(
                                    'Mes achats',
                                    style: AppTextStyle.appBarTextStyle,
                                  ),
                      centerTitle: true,
                                   //  actions: const [NotificationWidget()],
                                   
                                   ),
                         
                                 
                        SliverList.builder(
                          itemCount: c.commands.length,
                          itemBuilder: (context, index) {
                         return InkWell(
                          onTap: () {
                            c.selectReclamation( c.commands[index]);
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const OrderTrackingScreen()));
                          },
                          child: CommandItem(index: index+1,reference:  c.commands[index].reference,date:  c.commands[index].date!,price:  c.commands[index].price,));
                                })
                        
                      
                     ]);
                      }else if (snapashot.connectionState==ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator(),);

                      }else{
                                                return const Center(child: Text('error'),);

                      }
                    },

                   )
            
                ),
    );
  }
}