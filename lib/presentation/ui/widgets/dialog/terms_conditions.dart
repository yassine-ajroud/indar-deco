import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/presentation/controllers/settings_controller.dart';


class TermsAndConditionsDialog extends StatelessWidget {
  const TermsAndConditionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find() ;
       return AlertDialog(
  title:  Text(AppLocalizations.of(context)!.terms_conditions),
  titleTextStyle: AppTextStyle.blackTitleTextStyle.copyWith(fontWeight: FontWeight.bold),
  backgroundColor: Colors.white,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),
  content: SingleChildScrollView(
    child: tems_and_conditions(settingsController.currentlocale),
  ),
);
  }
}

Text tems_and_conditions(String local){
  switch (local) {
    case 'en':
      return  Text("""1. Introduction\n\nWelcome to Instar! By accessing or using our application, you agree to comply with these Terms and Conditions. If you do not agree, please do not use the application.\n\n2. Accounts\n\n- To use certain features, you must create an account.\n- You are responsible for keeping your account credentials secure.\n- You must provide accurate information when creating an account.
  
3. User Conduct

- Users must use the app responsibly and comply with applicable laws.
- You agree not to misuse the app, including uploading harmful, offensive, or unauthorized content.

4. Content Submission

- Users can submit comments and images on products.
- By submitting content, you grant Instar the right to use, modify, and display your content.
- Instar is not responsible for user-generated content and reserves the right to remove inappropriate content.

5. Orders and Payments

- Suppliers are responsible for fulfilling orders and ensuring product availability.
- Users must ensure payment information is accurate and sufficient funds are available.
-  Instar is not liable for disputes between suppliers and users regarding orders.

6. Augmented Reality (AR) Features

- AR visualizations are provided for convenience and may not perfectly represent the product.
- Users are advised to verify product details before making a purchase.

7. Data Privacy

- We store data on secure AWS servers and take measures to protect your information.
- By using the app, you consent to our data collection and usage as outlined in our Privacy Policy.

8. Liability

Instar is not liable for any damages arising from app use, including AR feature accuracy, user interactions, or third-party services.

9. Termination

We reserve the right to suspend or terminate accounts for violations of these terms.

10. Changes to Terms

Instar may update these terms periodically. Continued use of the app constitutes acceptance of the updated terms.

11. Contact Us

For questions or concerns, contact us at dhaouadinstar2024@gmail.com.""",style:AppTextStyle.blackTextStyle,);
    case 'fr':
      return  Text("""1. Introduction

Bienvenue sur Instar ! En accédant à notre application ou en l'utilisant, vous acceptez de respecter ces Conditions Générales d'Utilisation. Si vous n'êtes pas d'accord, veuillez ne pas utiliser l'application.

2. Comptes

- Certaines fonctionnalités nécessitent la création d'un compte.
- Vous êtes responsable de la confidentialité de vos identifiants.
- Vous devez fournir des informations exactes lors de la création de votre compte.

3. Conduite de l’utilisateur

- Les utilisateurs doivent utiliser l’application de manière responsable et respecter les lois en vigueur.
- Vous vous engagez à ne pas utiliser l’application pour diffuser des contenus nuisibles, offensants ou non autorisés.

4. Soumission de contenu

- Les utilisateurs peuvent soumettre des commentaires et des images sur les produits.
- En soumettant du contenu, vous accordez à Instar le droit de l’utiliser, le modifier et le publier.
- Instar n’est pas responsable du contenu généré par les utilisateurs et se réserve le droit de supprimer tout contenu inapproprié.

5. Commandes et paiements

- Les fournisseurs sont responsables de la gestion des commandes et de la disponibilité des produits.
- Les utilisateurs doivent s’assurer que les informations de paiement sont exactes et que les fonds nécessaires sont disponibles.
- Instar décline toute responsabilité en cas de litiges entre les fournisseurs et les utilisateurs concernant les commandes.

6. Fonctionnalités en Réalité Augmentée (RA)

- Les visualisations en RA sont fournies à titre indicatif et peuvent ne pas représenter parfaitement le produit réel.
- Les utilisateurs sont invités à vérifier les détails des produits avant de passer une commande.

7. Confidentialité des données

- Nous stockons les données sur des serveurs sécurisés d’AWS et prenons des mesures pour protéger vos informations.
- En utilisant l’application, vous acceptez la collecte et l’utilisation de vos données, conformément à notre Politique de Confidentialité.

8. Responsabilité

Instar décline toute responsabilité pour les dommages résultant de l’utilisation de l’application, y compris l’exactitude des fonctionnalités en RA, les interactions entre utilisateurs ou les services tiers.
9. Résiliation

Nous nous réservons le droit de suspendre ou de supprimer les comptes en cas de violation des présentes conditions.

10. Modifications des Conditions

Instar peut modifier ces conditions périodiquement. L’utilisation continue de l’application vaut acceptation des conditions mises à jour.

11. Contactez-nous

Pour toute question ou préoccupation, contactez-nous à l’adresse dhaouadinstar2024@gmail.com.""",style:AppTextStyle.blackTextStyle,);
    case 'ar':
    return Text("""1. المقدمة
مرحبًا بكم في إنستار! باستخدامكم تطبيقنا أو الوصول إليه، فإنكم توافقون على الالتزام بهذه الشروط والأحكام. إذا لم توافقوا عليها، يُرجى عدم استخدام التطبيق.

2. الحسابات

- تتطلب بعض الميزات إنشاء حساب مستخدم.
- أنتم مسؤولون عن الحفاظ على سرية بيانات تسجيل الدخول الخاصة بكم.
- يجب تقديم معلومات دقيقة عند إنشاء الحساب.

3. سلوك المستخدم

- يجب على المستخدمين استخدام التطبيق بشكل مسؤول ووفقًا للقوانين المعمول بها.
- توافقون على عدم استخدام التطبيق لنشر محتوى ضار أو مسيء أو غير مصرح به.

4. إضافة المحتوى

- يمكن للمستخدمين إضافة تعليقات وصور على المنتجات.
- من خلال تقديم أي محتوى، تمنحون إنستار الحق في استخدامه وتعديله وعرضه.
- إنستار غير مسؤول عن المحتوى الذي يضيفه المستخدمون وتحتفظ بالحق في إزالة أي محتوى غير لائق.

5. الطلبات والمدفوعات

- يتحمل الموردون مسؤولية تجهيز الطلبات وضمان توفر المنتجات.
- يجب على المستخدمين التأكد من دقة معلومات الدفع وتوفر الأموال الكافية.
- لا تتحمل إنستار المسؤولية عن النزاعات بين الموردين والمستخدمين بخصوص الطلبات.

6. ميزات الواقع المعزز (AR)

- يتم تقديم العروض الافتراضية بتقنية الواقع المعزز لأغراض تسهيل الاستخدام، وقد لا تعكس المنتج الحقيقي بشكل دقيق.
- ننصح المستخدمين بالتحقق من تفاصيل المنتج قبل الشراء.

7. خصوصية البيانات

- نقوم بتخزين البيانات على خوادم AWS الآمنة ونتخذ تدابير لحماية معلوماتكم.
- باستخدامكم للتطبيق، فإنكم توافقون على جمع بياناتكم واستخدامها وفقًا لسياسة الخصوصية الخاصة بنا.

8. المسؤولية

لا تتحمل إنستار أي مسؤولية عن أي أضرار تنجم عن استخدام التطبيق، بما في ذلك دقة ميزات الواقع المعزز أو التفاعلات بين المستخدمين أو الخدمات المقدمة من أطراف ثالثة.

9. إنهاء الحساب

نحتفظ بالحق في تعليق أو حذف الحسابات في حال انتهاك الشروط والأحكام.

10. تعديلات الشروط

يجوز لإنستار تعديل هذه الشروط بشكل دوري. استمراركم في استخدام التطبيق يعني قبولكم للشروط المعدلة.

11. اتصلوا بنا

لأي استفسارات أو ملاحظات، يُرجى التواصل معنا عبر البريد الإلكتروني dhaouadinstar2024@gmail.com..
""",style:AppTextStyle.blackTextStyle,);    
    default:
    return  Text("""1. Introduction\n\nWelcome to Instar! By accessing or using our application, you agree to comply with these Terms and Conditions. If you do not agree, please do not use the application.\n\n2. Accounts\n\n- To use certain features, you must create an account.\n- You are responsible for keeping your account credentials secure.\n- You must provide accurate information when creating an account.
  
3. User Conduct

- Users must use the app responsibly and comply with applicable laws.
- You agree not to misuse the app, including uploading harmful, offensive, or unauthorized content.

4. Content Submission

- Users can submit comments and images on products.
- By submitting content, you grant Instar the right to use, modify, and display your content.
- Instar is not responsible for user-generated content and reserves the right to remove inappropriate content.

5. Orders and Payments

- Suppliers are responsible for fulfilling orders and ensuring product availability.
- Users must ensure payment information is accurate and sufficient funds are available.
-  Instar is not liable for disputes between suppliers and users regarding orders.

6. Augmented Reality (AR) Features

- AR visualizations are provided for convenience and may not perfectly represent the product.
- Users are advised to verify product details before making a purchase.

7. Data Privacy

- We store data on secure AWS servers and take measures to protect your information.
- By using the app, you consent to our data collection and usage as outlined in our Privacy Policy.

8. Liability

Instar is not liable for any damages arising from app use, including AR feature accuracy, user interactions, or third-party services.

9. Termination

We reserve the right to suspend or terminate accounts for violations of these terms.

10. Changes to Terms

Instar may update these terms periodically. Continued use of the app constitutes acceptance of the updated terms.

11. Contact Us

For questions or concerns, contact us at dhaouadinstar2024@gmail.com.""",style:AppTextStyle.blackTextStyle,);
  }
}
