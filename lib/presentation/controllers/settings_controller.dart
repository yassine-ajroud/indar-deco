import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:indar_deco/core/utils/string_const.dart';

import '../../data/data_sources/local_data_source/settings_local_data_source.dart';


class SettingsController extends GetxController{
  String currentlocale='ar';
  bool expandedlanguge=false;
  bool expandedContact=false;
  bool activeNotification=false;


  Future<bool> loadNotif()async{
    activeNotification = await SettingsLocalDataSourcImpl().loadNotifications();
        update();
    return activeNotification;
  }

  Future setNotif(bool notification)async{
    activeNotification = notification;
     await SettingsLocalDataSourcImpl().saveNotifications(notification);
    update();
  }



  Future<String> loadLocale()async{
    currentlocale = await SettingsLocalDataSourcImpl().loadLocale();
    await loadNotif();
        update();

    return currentlocale;
  }

  void setLocal(String value){
    currentlocale = value;
    update();
  }


  void toggleLangugeExpandable(bool value){
    expandedlanguge = value;
    update([ControllerID.UPDTAE_LANGUAGE]);
  }

  void toggleContactExpandable(bool value){
    expandedContact = value;
    update([ControllerID.UPDTAE_CONTACT]);
  }
  void toggleNotification(bool value){
    activeNotification = value;
    update([ControllerID.UPDTAE_NOTIFICATION]);
  }

   Future<void> saveLocale(String locale)async{
   await SettingsLocalDataSourcImpl().saveLocale(locale);
       currentlocale = locale;
        update();
  }
}