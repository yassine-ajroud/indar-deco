import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/presentation/controllers/rating_controller.dart';

// ignore: must_be_immutable
class RatingStarWidget extends StatelessWidget {
  int index;
  RatingStarWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingController>(
      init: RatingController(),
      builder:(controller)=> InkWell(
        onTap: 
 () async {
            if (controller.localRate == 0) {
              await controller.addRating(index);
              controller.setRating(index);
            } else if (index == 1 &&
                controller.localRate == 1) {
              await controller
                  .deleteRating(controller.userRate!.id!);
              controller.localRate == 0;
            } else {
              await controller.updateRating(index);
            }
          },
        child: Icon(controller.localRate > index - 1? Icons.star: Icons.star_border,
                    color: AppColors.primary,size:controller.localRate > index - 1? 35:30,),
      )
          
    );
}
}