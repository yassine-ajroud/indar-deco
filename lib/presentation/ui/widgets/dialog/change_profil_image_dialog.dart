import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';



class ProfileImageDialog extends StatefulWidget {
  const ProfileImageDialog({super.key});

  @override
  State<ProfileImageDialog> createState() => _ProfileImageDialogState();
}

class _ProfileImageDialogState extends State<ProfileImageDialog> {

@override
  void initState() {
   final AuthenticationController controller = Get.find();
            controller.setuserImage(controller.currentUser.image??'');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<AuthenticationController>(
     id: ControllerID.UPDATE_USER_IMAGE,
      builder:(controller) {

        return AlertDialog(
      title:  Text(AppLocalizations.of(context)!.update_profile_picture),
      titleTextStyle: const TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: 20),
      backgroundColor: Colors.white,
      shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      content:  SizedBox(
        height: 150.h,
        child: Stack(
         alignment: AlignmentDirectional.center,
         children: [
        GestureDetector(
          onTap: ()async{
         await controller.pickImage();
          },
          child: CircleAvatar(
                               radius: 80,
                             backgroundImage:controller.userImage== '' ? Image.asset('assets/images/userImage.jpeg').image:controller.f==null? NetworkImage(controller.userImage):Image.file(controller.f!).image,
                             ),
        ),
                          controller.currentUser.image!= '' ? Positioned(
                         top: 0,
                         right: 0,
                         child: CircleAvatar(
                           backgroundColor: Colors.white,
                           child: IconButton(icon:const Icon(Icons.clear),onPressed: ()async{
                             controller.setuserImage(controller.userImage==''?controller.currentUser.image!:'');
                           },),)):Container(),
         ],
        ),
      ),
actionsPadding: const EdgeInsets.symmetric(horizontal:20,vertical: 10),
  actions: [
    TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text(AppLocalizations.of(context)!.cancel)),
   PrimaryButton(text: AppLocalizations.of(context)!.save, color:controller.currentUser.image!=controller.userImage ?AppColors.primary:AppColors.grey ,
            click:controller.currentUser.image!=controller.userImage?()async{
             
                await controller.updateImage(context);
                
      
            }:null),
  ]

          );
      },
    );
  }
}