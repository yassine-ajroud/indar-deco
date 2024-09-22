import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/enums.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/review_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/comment/pick_review_image_dialog.dart';
import 'package:indar_deco/presentation/ui/widgets/comment/update_review_dialog.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class CommentWidget extends StatefulWidget {
  final String productId;

  const CommentWidget({super.key, required this.productId});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late final ReviewController controller;
  late final TextEditingController editingController;
  late final ScrollController scrollController;
  late final AuthenticationController authenticationController;

  @override
  void initState() {
    controller = ReviewController();
    editingController = TextEditingController();
    scrollController = ScrollController();
    authenticationController= Get.find();
    super.initState();
  }

  @override
  void dispose() {
    editingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(
      init: ReviewController(),
      builder: (controller) => FutureBuilder(
        future: controller.getProductReviews(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  constraints: const BoxConstraints(
                      minHeight: 50, minWidth: double.infinity, maxHeight: 400),
                  child: controller.allreviews.isEmpty
                      ? Text(
                          AppLocalizations.of(context)!.no_comments,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.lightLabelTextStyle,
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: controller.allreviews.length,
                          itemBuilder: (_, index) {
                             // scrollController
                                // .jumpTo(scrollController.position.maxScrollExtent);
                            return PopupMenuButton(
                              onSelected: (value) async {
                                switch (value) {
                                  case MyActions.update:
                                    await showDialog(
                                        context: context,
                                        builder: (ctx) => UpdateReviewDialog(newReview:controller.allreviews[index]));
                                    break;
                                  case MyActions.delete:
                                    await controller.deletComment(
                                        controller.allreviews[index].id!);
                                    break;
                                }
                              },
                              enableFeedback: true,
                              enabled: controller.allreviews[index].userID ==
                                authenticationController.currentUser.id,
                              itemBuilder: ((context) =>  [
                                    PopupMenuItem(
                                      value: MyActions.update,
                                      child: Text(AppLocalizations.of(context)!.update),
                                    ),
                                    PopupMenuItem(
                                        value: MyActions.delete, child: Text(AppLocalizations.of(context)!.delete))
                                  ]),
                              child: ListTile(
                                leading: 
                                
                               CircleAvatar(
                                  backgroundImage:controller.getReviewUser(controller.allreviews[index].userID).image=='' ? Image.asset('assets/images/userImage.jpeg').image:NetworkImage(controller.getReviewUser(controller.allreviews[index].userID).image!),
                                ),
                                title: Text('${ controller.getReviewUser(controller.allreviews[index].userID).firstName} ${ controller.getReviewUser(controller.allreviews[index].userID).lastName}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.allreviews[index].comment),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    controller.allreviews[index].image == ''
                                        ? Container()
                                        : Image.network(
                                            controller.allreviews[index].image!,
                                            height: 150,
                                          )
                                  ],
                                ),
                                trailing: Text(
                                    DateFormat('yyyy-MM-dd')
                                        .format(controller.allreviews[index].date!)
                                        .toString(),
                                    style: AppTextStyle.smallGreyTextStyle),
                              ),
                            );
                          },
                        )),
              controller.f != null
                  ? Stack(children: [
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Image.file(controller.f!,fit: BoxFit.contain,)),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                              onPressed: () {
                                controller.clearImage();
                              },
                              icon: const Icon(Icons.clear)))
                    ])
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  onChanged: (s) {
                    controller.typeComment(s);
                  },
                  minLines: 1,
                  maxLines: 3,
                  controller: editingController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.write_your_comment,
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: controller.comment == ''
                                ? null
                                : () async {
                                  await controller.addReview().then((value) => editingController.clear());
                                  },
                            icon: const Icon(Icons.send)),
                        IconButton(
                            onPressed: () async{
                              await showDialog(context: context, builder: (_)=>const PickReviewImageDialog());
                            },
                            icon: const Icon(Icons.image_outlined)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
