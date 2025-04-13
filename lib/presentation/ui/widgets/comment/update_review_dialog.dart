// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/utils/svg.dart';
import 'package:indar_deco/domain/entities/review.dart';
import 'package:indar_deco/presentation/controllers/review_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateReviewDialog extends StatefulWidget {
    final Review newReview;

  const UpdateReviewDialog({super.key, required this.newReview});

  @override
  State<UpdateReviewDialog> createState() => _UpdateReviewDialogState();
}
String updatecomment='';
 final TextEditingController textEditingController=TextEditingController();
class _UpdateReviewDialogState extends State<UpdateReviewDialog> {
  @override
  void initState() {
    final ReviewController reviewController= Get.find();
    updatecomment =widget.newReview.comment;
    reviewController.updatefileName=widget.newReview.image??'';
    textEditingController.text=widget.newReview.comment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
      init: ReviewController(),
      builder: (controller) {
        return AlertDialog(
              title: Text(
                 AppLocalizations.of(context)!.update_comment,
               // style: AppTextStyle.subTitleTextStyle,
              ),
              content: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      AppLocalizations.of(context)!.upload_image,
                                      //style: AppTextStyle.subTitleTextStyle,
                                    ),
                                    content: Padding(
                                      padding:const EdgeInsets.symmetric(vertical: 30),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                await controller.pickImageFromGalleryUpdate(context);
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                  Icons.image,
                                                  size: 40,
                                                  color: AppColors.secondary,
                                                )),
                                            IconButton(
                                                onPressed: () async {
                                                 await controller.pickImageFromCameraUpdate(context);
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                  Icons.camera_alt,
                                                  size: 40,
                                                  color: AppColors.secondary,
                                                )),
                                          ]),
                                    ),
                                  );
                                });
                          },
                          child: controller.updatef != null
                              ? Stack(children: [
                                  Image.file(controller.updatef!),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () {
                                         controller.clearUpdateFile();
                                          },
                                          icon: const Icon(Icons.clear)))
                                ])
                              : controller.updatefileName ==''
                                  // ignore: deprecated_member_use
                                  ?  SvgPicture.string(APPSVG.pickImageIcon,color: AppColors.darkGrey,width: 100,)
                                  : Stack(
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Image.network(
                                              widget.newReview.image!,height: 150,),
                                        ),
                                        Positioned(
                                            top: 0,
                                            right: 0,
                                            child: IconButton(
                                                onPressed: () {
                                                    controller.clearUpdateFile();
                                                },
                                                icon: const Icon(Icons.clear)))
                                      ],
                                    ),
                          // onTap: ,
                        ),
                        TextField(
                          onChanged: (s) {
                         updatecomment = s;
                          },
                          minLines: 1,
                          maxLines: 3,
                         controller: textEditingController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.write_your_comment,
                          ),
                        ),
                       const SizedBox(
                          height: 40,
                        ),

PrimaryButton(text:AppLocalizations.of(context)!.update , click: ()async{
        await controller.updateComment(widget.newReview,updatecomment);
           Navigator.of(context).pop();
}),
                                     
                        TextButton(
                            onPressed: () {
                              controller.clearUpdateFile();
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context)!.cancel))
                      ],
                    ),
                  )),
            );
      }
    );
  }
}