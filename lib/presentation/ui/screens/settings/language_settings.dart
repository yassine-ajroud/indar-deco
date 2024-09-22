import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:indar_deco/presentation/controllers/settings_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/settings_component/language_item.dart';
import '../../../../core/styles/text_styles.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          AppLocalizations.of(context)!.lang,
          style: AppTextStyle.appBarTextStyle,
        ),
      ),
      body: SafeArea(
        child: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (controller) {
            return Column(
              children: [
                LanguageItem(
                  language: AppLocalizations.of(context)!.fr,
                  value: 'fr',
                  gvalue: controller.currentlocale,
                  onChanged: (v) async{
                    await controller.saveLocale(v!);
                  },
                ),
                LanguageItem(
                    language: AppLocalizations.of(context)!.en,
                    value: 'en',
                     gvalue: controller.currentlocale,
                  onChanged: (v) async{
                    await controller.saveLocale(v!);
                  },),
                LanguageItem(
                  language: AppLocalizations.of(context)!.ar,
                  value: 'ar',
                   gvalue: controller.currentlocale,
                  onChanged: (v) async{
                    await controller.saveLocale(v!);
                  },
                ),
                
              ],
            );
          },
        ),
      ),
    );
  }
}
