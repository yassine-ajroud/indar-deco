import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/utils/svg.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/ui/screens/authentication/update_password_screen.dart';
import 'package:indar_deco/presentation/ui/screens/authentication/update_profile_screen.dart';
import 'package:indar_deco/presentation/ui/screens/settings/settings.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/profile_button.dart';
import 'package:indar_deco/presentation/ui/widgets/dialog/change_profil_image_dialog.dart';
import 'package:indar_deco/presentation/ui/widgets/dialog/log_out_dialog.dart';
import '../../../../core/styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(AppLocalizations.of(context)!.profile,style: AppTextStyle.appBarTextStyle,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GetBuilder<AuthenticationController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 120.h,
                      child: Stack(
                        children: [
                        CircleAvatar(
                          backgroundImage:controller.currentUser.image== '' ? Image.asset('assets/images/userImage.jpeg').image:NetworkImage(controller.currentUser.image!),
                          radius: 60.r,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(child: GestureDetector(
                            onTap: (){
                               showDialog(context: context, builder: (_)=> const ProfileImageDialog());
                            },
                            child: SvgPicture.string(APPSVG.cameraIcon,height: 30.h,))))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          style: AppTextStyle.blackTitleTextStyle,
                          '${controller.currentUser.firstName} ${controller.currentUser.lastName}'),
                    ),
                    Text(
                        style: AppTextStyle.lightLabelTextStyle,
                       controller.currentUser.oAuth==null? controller.currentUser.email:  controller.currentUser.oAuth=='F'?AppLocalizations.of(context)!.logged_with_facebook:AppLocalizations.of(context)!.logged_with_google
                        ),

                     const SizedBox(height:20,),
                     
                     controller.currentUser.oAuth !=null? Container(): ProfileButton(text: AppLocalizations.of(context)!.edit_user_infos,icon:APPSVG.userIcon,
                      alert: controller.missingData,
                      onClick: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const UpdateProfileScreen()));
                     }),
                     controller.currentUser.oAuth !=null? Container(): ProfileButton(
                      alert: controller.missingRecoveryEmail,
                        text: AppLocalizations.of(context)!.confidentiality,icon:APPSVG.securityIcon, onClick: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const UpdatePasswordScreen()));

                        }),
                         ProfileButton(
                          onClick: (){
                            
                          },
                        text: AppLocalizations.of(context)!.my_orders,icon: APPSVG.walletIcon),
                        ProfileButton(
                        text: AppLocalizations.of(context)!.settings,icon:APPSVG.settingsIcon,onClick: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const SettingsScreen()));
                        },),
                       const SizedBox(height: 30,),
                              ProfileButton(
                        text: AppLocalizations.of(context)!.logout,icon:APPSVG.logoutIcon,
                        onClick: ()async{
                             showDialog(context: context, builder: ((ctx) =>const LogoutDialog() ));       
                            
                        },),
                                       // const SizedBox(height:70,),


                  ]),
            );
          },
        ),
      ),
    );
  }
}
