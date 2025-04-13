import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/core/l10n/plural_strings.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/core/utils/svg.dart';
import 'package:indar_deco/domain/entities/sales.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/cart_controller.dart';
import 'package:indar_deco/presentation/controllers/category_controller.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';
import 'package:indar_deco/presentation/controllers/promotion_controller.dart';
import 'package:indar_deco/presentation/controllers/rating_controller.dart';
import 'package:indar_deco/presentation/controllers/review_controller.dart';
import 'package:indar_deco/presentation/controllers/supplier_controller.dart';
import 'package:indar_deco/presentation/ui/screens/AR/ar_objects_screen.dart';
import 'package:indar_deco/presentation/ui/screens/supplier/supplier_screen.dart';
import 'package:indar_deco/presentation/ui/widgets/app_bar/product_screen_app_bar.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:indar_deco/presentation/ui/widgets/buttons/quantity_button.dart';
import 'package:indar_deco/presentation/ui/widgets/comment/comment.dart';
import 'package:indar_deco/presentation/ui/widgets/product/texture_item.dart';
import 'package:indar_deco/presentation/ui/widgets/rating/rating_section.dart';
import 'package:o3d/o3d.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SupplierController supplierController = Get.find();
    Get.put(RatingController());
    Get.put(ReviewController());

    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
            child: GetBuilder<ProductController>(
          init: ProductController(),
          builder: (pc) => FutureBuilder(
              future: pc.getProductsById(pc.currentProductid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CustomScrollView(
                    slivers: [
                      const ProductScreenSliverAppBar(),
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          height: 270.h,
                          child: GetBuilder(
                              id: ControllerID.PRODUCT_TEXTURE,
                              init: ProductController(),
                              builder: (controller3d) {
                                return Stack(
                                  children: [
                                    SizedBox(
                                      height: 250.h,
                                      child: O3D.network(
                                        backgroundColor: AppColors.background,
                                        key: controller3d.textureKey,
                                        src: controller3d
                                            .selected3Dproduct.model3D,
                                      ),
                                    ),
                                    Positioned(
                                        right: 15.w,
                                        bottom: 15.w,
                                        child: FloatingActionButton(
                                          backgroundColor: AppColors.white,
                                          shape: const CircleBorder(),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ObjectGesturesWidget(
                                                          models: [
                                                            controller3d
                                                                .selected3Dproduct
                                                          ],
                                                          isSingleProduct: true,
                                                        )));
                                          },
                                          child: SvgPicture.string(
                                            APPSVG.arIcon,
                                            width: 20.r,
                                            // ignore: deprecated_member_use
                                            color: AppColors.black,
                                          ),
                                        ))
                                  ],
                                );
                              }),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 240.w,
                                    child: Text(snapshot.data!.name.toString(),
                                        style: AppTextStyle
                                            .producDescTitiletTextStyle),
                                  ),
                                  GetBuilder<ProductController>(
                                      init: ProductController(),
                                      id: ControllerID.PRODUCT_TEXTURE,
                                      builder: (textureController) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              QuantityButton(
                                                backgroundColor:
                                                    AppColors.lightgrey,
                                                icon: Icons.remove,
                                                onPress: () {
                                                  textureController
                                                      .decrementQuantity();
                                                },
                                                color: AppColors.black,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                textureController.quantity
                                                    .toString(),
                                                style: AppTextStyle
                                                    .blackTitleTextStyle,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              QuantityButton(
                                                backgroundColor:
                                                    AppColors.primary,
                                                icon: Icons.add,
                                                onPress: () {
                                                  textureController
                                                      .incrementQuantity();
                                                },
                                                color: AppColors.white,
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap:() {
                                        supplierController.selectSupplier( snapshot.data!.provider);
                                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const SupplierScreen()));},
                                      child: Text(
                                        supplierController.productSupplier(
                                            snapshot.data!.provider),
                                        style: AppTextStyle.supplierNameTextStyle,
                                      ),
                                    ),
                                  ),
                                  pc.currentProduct.promotion
                                      ? GetBuilder<PromotionController>(
                                          init: PromotionController(),
                                          builder: (promoController) {
                                            return GetBuilder(
                                                init: ProductController(),
                                                id: ControllerID
                                                    .PRODUCT_TEXTURE,
                                                builder: (textureController) {
                                                  return Row(
                                                    children: [
                                                      FutureBuilder(
                                                          future: promoController
                                                              .getPromotionPrice(pc
                                                                  .currentProduct
                                                                  .id!),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              return Text(
                                                                  '${(snapshot.data! * textureController.quantity).toStringAsFixed(3)} ${AppLocalizations.of(context)!.dinar}',
                                                                  style: AppTextStyle
                                                                      .mainPriceTextStyle);
                                                            }
                                                            return const SizedBox();
                                                          }),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        '${pc.currentProduct.price}${AppLocalizations.of(context)!.dinar}',
                                                        style: AppTextStyle
                                                            .oldPriceTextStyle,
                                                      )
                                                    ],
                                                  );
                                                });
                                          })
                                      : GetBuilder(
                                          init: ProductController(),
                                          id: ControllerID.PRODUCT_TEXTURE,
                                          builder: (textureController) {
                                            return Flexible(
                                              flex: 1,
                                              child: Text(
                                                  '${(snapshot.data!.price * textureController.quantity).toStringAsFixed(2)} ${AppLocalizations.of(context)!.dinar}',
                                                  style: AppTextStyle
                                                      .mainPriceTextStyle),
                                            );
                                          }),
                                ],
                              ),

                              SizedBox(
                                height: 65.h,
                                width: 180.w,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  //  shrinkWrap: true,
                                  itemCount: pc.productColors.length,
                                  itemBuilder: (context, index) {
                                    return TextureItem(
                                        product: pc.productColors[index]);
                                  },
                                ),
                              ),
                              GetBuilder(
                                  init: ProductController(),
                                  id: ControllerID.PRODUCT_TEXTURE,
                                  builder: (textureController) {
                                    return PluralStrings.onOrder(
                                        textureController
                                            .selected3Dproduct.quantity,
                                        context);
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                AppLocalizations.of(context)!.description,
                                style: AppTextStyle.subTitleTextStyle,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(snapshot.data!.description,
                                  style: AppTextStyle.descriptionTextStyle),
                              const SizedBox(height: 10),
                              GetBuilder(
                                  init: CategoryController(),
                                  builder: (categoryController) {
                                    return Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: 'Category: ',
                                          style: AppTextStyle
                                              .descriptionBoldTextStyle),
                                      TextSpan(
                                          text:
                                              '${categoryController.getCategoryName(snapshot.data!.category)} > ${categoryController.getsubCategoryName(snapshot.data!.subCategory)}',
                                          style:
                                              AppTextStyle.descriptionTextStyle)
                                    ]));
                                  }),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: 'Dimensions: ',
                                    style:
                                        AppTextStyle.descriptionBoldTextStyle),
                                TextSpan(
                                    text:
                                        pc.getProductDimensions(snapshot.data!.dimensions,context),
                                    style: AppTextStyle.descriptionTextStyle)
                              ])),
                              const SizedBox(
                                height: 20,
                              ),
                              // ignore: prefer_const_constructors
                              RatingSection(),

                              SizedBox(
                                height: 15.h,
                              ),
                              GetBuilder(
                                  init: ReviewController(),
                                  id: ControllerID.TOGGLE_COMMENT,
                                  builder: (reviewController) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .comments,
                                          style: AppTextStyle.subTitleTextStyle,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              reviewController
                                                  .toggleCommentSection();
                                            },
                                            icon: reviewController.expanded
                                                ? const Icon(
                                                    Icons
                                                        .keyboard_arrow_up_rounded,
                                                    color: AppColors.primary,
                                                  )
                                                : const Icon(Icons
                                                    .keyboard_arrow_down_rounded))
                                      ],
                                    );
                                  }),
                              GetBuilder(
                                  init: ReviewController(),
                                  builder: (reviewController) {
                                    return ExpandablePanel(
                                        controller: reviewController
                                            .expandableController,
                                        collapsed: Container(),
                                        expanded: CommentWidget(
                                            productId: pc.currentProductid));
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              GetBuilder(
                                  init: CartController(),
                                  builder: (cartController) {
                                    return GetBuilder(
                                        id: ControllerID.PRODUCT_TEXTURE,
                                        init: ProductController(),
                                        builder: (controller3d) {
                                          return PrimaryButton(
                                            text: AppLocalizations.of(context)!
                                                .add_to_cart,
                                            click: () async {
                                              final AuthenticationController
                                                  authenticationController =
                                                  Get.find();
                                          await    cartController.addSale(Sales(
                                                  modelId:
                                                      pc.selected3Dproduct.id,
                                                  productId:
                                                      pc.currentProductid,
                                                  providerId: pc
                                                      .currentProduct.provider,
                                                  userId:
                                                      authenticationController
                                                          .currentUser.id!,
                                                  quantity: pc.quantity,
                                                  totalPrice: pc.quantity *
                                                      pc.getPrice(
                                                          pc.currentProduct)));
                                            },
                                            disabled: controller3d
                                                    .selected3Dproduct
                                                    .quantity <
                                                1,
                                          );
                                        });
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Text('error');
                }
              }),
        )));
  }
}
