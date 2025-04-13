import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/presentation/controllers/notifications_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/notification/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void dispose() async {
    super.dispose();
    final NotificationsController notificationsController = Get.find();
    await notificationsController.markAsSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
          init: NotificationsController(),
          builder: (controller) {
            return FutureBuilder(
               future: controller.getNotifications(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if(snapshot.hasData){
       return  CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: true,
                      backgroundColor: AppColors.background,
                      shadowColor: AppColors.lightShadow,
                      title: Text(
                        AppLocalizations.of(context)!.notifications,
                        style: AppTextStyle.appBarTextStyle,
                      ),
                      elevation: 4,
                      snap: true,
                      pinned: true,
                      floating: true,
                    ),
                    
                    controller.allNotifs.isEmpty
                                    ? SliverToBoxAdapter(
                                      child: Center(
                                          child: Text(
                                          AppLocalizations.of(context)!
                                              .no_notifications,
                                          style: AppTextStyle.blackTextStyle,
                                        )),
                                    )
                                    : SliverList.builder(itemBuilder:  (context, index) =>
                                            NotificationItem(
                                              notificationID:controller.allNotifs[index].id ,
                                              content:"${AppLocalizations.of(context)!.update_order_status} ${controller.allNotifs[index].content}",
                                              date: controller.allNotifs[index].date!,
                                              senderId: controller
                                                  .allNotifs[index].senderId,
                                              seen: controller.allNotifs[index].seen,
                                            ),itemCount: controller.allNotifs.length,)    
                  ],
                );
                }  else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
              return const Text('error');
                
                
                
         
              }
            );
          }
        ),
      ),
    );
  }
}