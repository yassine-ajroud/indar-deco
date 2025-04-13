import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/string_const.dart';
import '../../../core/errors/exceptions/exceptions.dart';

abstract class SettingsLocalDataSourc {
  Future<String> loadLocale();
  Future<void> saveLocale(String locale);
  Future<bool> loadNotifications();
  Future<void> saveNotifications(bool notif);
}

class SettingsLocalDataSourcImpl
    implements SettingsLocalDataSourc {
      @override
      Future<String> loadLocale() async{
    try {
      final sp = await SharedPreferences.getInstance();
      final data = sp.getString(StringConst.SP_LANGUAGE_KEY)??'fr';
      return data;
    } catch (e) {
      throw LocalStorageException();
    }
      }
    
      @override
      Future<void> saveLocale(String locale) async{
      try {
      final sp = await SharedPreferences.getInstance();
      sp.setString(StringConst.SP_LANGUAGE_KEY,locale);
    } catch (e) {
      throw LocalStorageException();
    }
      }
      
        @override
        Future<bool> loadNotifications()async {
              try {
      final sp = await SharedPreferences.getInstance();
      final data = sp.getBool(StringConst.SP_NOTIFICATION_KEY)??false;
      return data;
    } catch (e) {
      throw LocalStorageException();
    }
        }
      
        @override
        Future<void> saveNotifications(bool notif)async {
           try {
      final sp = await SharedPreferences.getInstance();
      sp.setBool(StringConst.SP_NOTIFICATION_KEY,notif);
    } catch (e) {
      throw LocalStorageException();
    }
        }
 


}
