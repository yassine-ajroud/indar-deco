import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/presentation/ui/widgets/settings_component/settings_header.dart';
import '../../../../core/styles/text_styles.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
           AppLocalizations.of(context)!.help_center,
          style: AppTextStyle.appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SettingsHeader(text: AppLocalizations.of(context)!.contact_support),
             const SizedBox(height: 20,),
              Text('${AppLocalizations.of(context)!.address} :',style: AppTextStyle.smallBlackTitleTextStyle,),
                  const SizedBox(height: 5,),
          Text('R56P+C9J, Av. Mohamed 5, Tunis',style: AppTextStyle.descriptionTextStyle,),
      
          const SizedBox(height: 20,),
          Text('${AppLocalizations.of(context)!.phone_number} :',style: AppTextStyle.smallBlackTitleTextStyle,),
                      const SizedBox(height: 5,),
          Text('+216 71 000 000',style: AppTextStyle.descriptionTextStyle,),
      
          const SizedBox(height: 20,),
          Text('${AppLocalizations.of(context)!.email} :',style: AppTextStyle.smallBlackTitleTextStyle,),
                      const SizedBox(height: 5,),
          Text('Instarcontact@gmail.com',style: AppTextStyle.descriptionTextStyle,)
      
                
              ],
            ),
      )
      
    );
  }
}
