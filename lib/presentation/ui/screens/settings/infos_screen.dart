import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/presentation/controllers/settings_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/settings_component/settings_header.dart';
import '../../../../core/styles/text_styles.dart';

class InfosScreen extends StatelessWidget {
  const InfosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          AppLocalizations.of(context)!.what_is_instar,
          style: AppTextStyle.appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SettingsHeader(text: AppLocalizations.of(context)!.who_are_we),
               const SizedBox(height: 20,),
                Text(_getDescription(),style: AppTextStyle.descriptionTextStyle,),
        
                ],
              ),
        ),
      )
      
    );
  }
}

String _getDescription(){
  final SettingsController s = Get.find();
  if (s.currentlocale=="ar"){
    return """
    إنستار هي شركة ناشئة في مجال تكنولوجيا تجارة التجزئة، متخصصة في التجارة الغامرة باستخدام الواقع المعزز (AR) والواقع الافتراضي (VR). من خلال تطبيقها الأول IndAR، تُحدث إنستار ثورة في تجربة شراء الأثاث والديكور الحرفي من خلال تقديم:

-صالة عرض افتراضية بتقنية VR للموردين والحرفيين،

-عرض المنتجات باستخدام تقنية AR مباشرة في مساحة المستخدم،

-ميزات تخصيص المنتجات قبل الشراء،

-حماية الابتكارات باستخدام تكنولوجيا NFT،

-ومحرك توصية ذكي قائم على الذكاء الاصطناعي.

هدفنا هو تحديث قطاع الأثاث مع تعزيز المهارات المحلية، من خلال تقريب الحرفيين والموردين من عملائهم عبر تجربة غامرة، بديهية ومبتكرة.
    """;
  }else if(s.currentlocale=="fr"){
    return """
Instar est une startup Retailtech spécialisée dans le commerce immersif en réalité augmentée (AR) et réalité virtuelle (VR). À travers sa première application IndAR, Instar révolutionne l’expérience d’achat de meubles et de décoration artisanale en offrant:

-Un showroom virtuel en VR pour les fournisseurs et artisans,

-Une visualisation AR des produits directement dans l’espace de l’utilisateur,

-Des fonctionnalités de personnalisation des produits avant achat,

-Une protection des créations grâce à la technologie NFT,

-Et un moteur de recommandation intelligent basé sur l’IA.

Notre objectif est de moderniser le secteur de l’ameublement tout en valorisant le savoir-faire local, en rapprochant les artisans et fournisseurs de leurs clients grâce à une expérience immersive, intuitive et innovante.
""";
  }else{
    return """Instar is a startup in the retail tech field, specializing in immersive commerce using Augmented Reality (AR) and Virtual Reality (VR). Through its first app, IndAR, Instar is revolutionizing the furniture and handcrafted decoration shopping experience by offering\:

-A virtual VR showroom for suppliers and artisans,

-AR visualization of products directly in the user's space,

-Product customization features before purchase,

-Protection of creations using NFT technology,

-And a smart recommendation engine powered by AI.

Our goal is to modernize the furniture sector while promoting local craftsmanship, by bringing artisans and suppliers closer to their customers through an immersive, intuitive, and innovative experience.""";
  }
}
