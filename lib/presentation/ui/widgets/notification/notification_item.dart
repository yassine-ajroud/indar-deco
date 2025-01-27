import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/date.dart';
import 'package:indar_deco/presentation/controllers/notifications_controller.dart';
import 'package:indar_deco/presentation/controllers/supplier_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationItem extends StatelessWidget {
  final String notificationID;
  final String senderId;
  final String content;
  final DateTime date;
  final bool seen;
  const NotificationItem({super.key, required this.senderId, required this.content, required this.date,required this.seen,required this.notificationID});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: seen? AppColors.white:AppColors.lightgrey,
          borderRadius: BorderRadius.circular(8)
        ),
        child:Slidable(
            endActionPane: ActionPane(
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                                borderRadius: BorderRadius.circular(15),
                                backgroundColor: AppColors.primary,
                                icon: Icons.delete,
                                label: AppLocalizations.of(context)!.delete,
                                onPressed: (context) async {
                                final NotificationsController controller = Get.find();
                                await controller.deleteNotification(notificationID);                  
                                }),
                          ],
                        ),
          child: ListTile(title: GetBuilder(
            init: SupplierController(),
            builder: (controller) {
              return FutureBuilder(
                future: controller.getSupplierById(senderId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                        return Text(snapshot.data!.name,style: AppTextStyle.blackTitleTextStyle,);
                  } else {
                    return Container();
                  }
                }
              );
            }
          ),subtitle: Text(content,style: AppTextStyle.blackTextStyle,),trailing: Text(DateParser.getDateDifference(date, context),style: AppTextStyle.smallGreyTextStyle,),),
        )
       ),
    );
  }
}


