import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/core/l10n/plural_strings.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';
import 'package:indar_deco/presentation/controllers/rating_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/rating/rating_star_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key});
  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.find();
    return GetBuilder<RatingController>(
        init: RatingController(),
        builder: (controller) {
          return FutureBuilder(
              future: controller.getRating(productController.currentProductid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.rate_product,
                              style: AppTextStyle.subTitleTextStyle,
                            ),
                            Text(
                              PluralStrings.ratings(
                                  controller.productRating.number, context),
                              style: AppTextStyle.lightLabelTextStyle,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.productRating.avg.toString(),
                              style: AppTextStyle.ratingTextStyle,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            const VerticalDivider(
                              width: 2.0,
                              thickness: 2.0,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            RatingStarWidget(index: 1),
                            RatingStarWidget(index: 2),
                            RatingStarWidget(index: 3),
                            RatingStarWidget(index: 4),
                            RatingStarWidget(index: 5)
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              });
        });
  }
}
