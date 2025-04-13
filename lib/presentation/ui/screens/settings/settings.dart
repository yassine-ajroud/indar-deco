import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/svg.dart';
import 'package:indar_deco/presentation/controllers/settings_controller.dart';
import 'package:indar_deco/presentation/ui/screens/settings/help_screen.dart';
import 'package:indar_deco/presentation/ui/screens/settings/infos_screen.dart';
import 'package:indar_deco/presentation/ui/screens/settings/language_settings.dart';
import 'package:indar_deco/presentation/ui/widgets/settings_component/settings_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.black,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: AppTextStyle.appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            SettingsItem(
                text: AppLocalizations.of(context)!.lang,
                icon: APPSVG.translateIcon,
                trailing:InkWell(
                         onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectLanguageScreen(),
                )),
                  child:const Icon(Icons.arrow_forward_ios_rounded)),
                ),
                
           GetBuilder(
            init: SettingsController(),
             builder: (controller) {
               return SettingsItem(
                    text: AppLocalizations.of(context)!.notifications,
                    icon: APPSVG.notificationIcon,
                    trailing:Switch.adaptive(value:controller.activeNotification, onChanged: (v)async{
                     await controller.setNotif(v);
                    }),
                    );
             }
           ),
                        SettingsItem(
                text: AppLocalizations.of(context)!.help_center,
                icon: APPSVG.helpIcon,
                trailing:InkWell(
                         onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpScreen(),
                )),
                  child:const Icon(Icons.arrow_forward_ios_rounded)),
                ),
                   SettingsItem(
                text: AppLocalizations.of(context)!.what_is_instar,
                icon: APPSVG.infosIcon,
                trailing:InkWell(
                         onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfosScreen(),
                )),
                  child:const Icon(Icons.arrow_forward_ios_rounded)),
                ),
          ]),
        ),
      ),
    );
  }
}
