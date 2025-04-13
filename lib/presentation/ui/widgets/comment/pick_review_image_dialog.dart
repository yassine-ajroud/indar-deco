// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/presentation/controllers/review_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PickReviewImageDialog extends StatelessWidget {
  const PickReviewImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(
      init: ReviewController(),
      builder: (controler) {
        return AlertDialog(
                title: Text(
                  AppLocalizations.of(context)!.upload_image,
                  style: AppTextStyle.blackTitleTextStyle,
                ),
                content: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () async {
                            await controler.pickImageFromGallery(context);
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.image,
                              size: 40,
                              color: AppColors.secondary,
                            )),
                        IconButton(
                            onPressed: () async {
                               await controler.pickImageFromCamera(context);   
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
      }
    );
  }
}