import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/di.dart';
import 'package:indar_deco/domain/entities/notification.dart';
import 'package:indar_deco/domain/usecases/notification_usecases/delete_notification_usecase.dart';
import 'package:indar_deco/domain/usecases/notification_usecases/get_notifications_by_user.dart';
import 'package:indar_deco/domain/usecases/notification_usecases/update_notification_usecase.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';

class NotificationsController extends GetxController{
List<MyNotification> allNotifs=[];
int unseenCount=0;


Future<bool> getNotifications()async{
  final AuthenticationController authenticationController=Get.find();
  final res = await GetNotificationByUserUsecase(sl())(userID: authenticationController.currentUser.id!);
  res.fold((l) => null, (r) => allNotifs=r);
  getUnseenNotifications();
  return true;
} 

int getUnseenNotifications(){
  int count=0;
  int i=allNotifs.length-1;
  while ( i>=0&&!allNotifs[i].seen) {
    count++;
    i--;
  }
  unseenCount = count;
  update([ControllerID.NOTIFICATIONS_COUNT]);
  return count;
}

Future<void> markAsSeen()async{
  final length = allNotifs.length;
  for (var i = 1; i <= unseenCount; i++) {
   final res =  await UpdateNotificationUsecase(sl())(notification:MyNotification(id: allNotifs[length-i].id, userId: allNotifs[length-i].userId, senderId: allNotifs[length-i].senderId, content: allNotifs[length-i].content, seen: true));
  res.fold((l) => null, (r) => allNotifs[length-i]=r);
  }
    resetCount();
}
 @override
  void onInit() {
    getNotifications();
    super.onInit();
  }

  void resetCount(){
    if(unseenCount>0){
       unseenCount=0;
    update([ControllerID.NOTIFICATIONS_COUNT]);
    }
  }

  Future<void> deleteNotification(String notificationID)async{
    final res = await DeleteNotificationUsecase(sl())(notificationID: notificationID);
    res.fold((l) => null, (r) => allNotifs.remove(r));
    update();
  }

}