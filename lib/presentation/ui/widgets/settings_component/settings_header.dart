import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/adaptive.dart';
import 'package:indar_deco/presentation/controllers/settings_controller.dart';

class SettingsHeader extends StatelessWidget {
  final String text;
  const SettingsHeader({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController=Get.find();
    return Container(
      alignment: Adaptivity.alignmentLeft(settingsController.currentlocale),
      height: 70.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          text,style: AppTextStyle.blueTextStyle),
      )
    );
  }
}
