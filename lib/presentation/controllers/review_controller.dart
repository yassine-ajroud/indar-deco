import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/di.dart';
import 'package:indar_deco/domain/entities/review.dart';
import 'package:indar_deco/domain/entities/user.dart';
import 'package:indar_deco/domain/usecases/authentication_usecases/get_user_usecase.dart';
import 'package:indar_deco/domain/usecases/review_usecases/add_review_image_usecase.dart';
import 'package:indar_deco/domain/usecases/review_usecases/add_review_usecase.dart';
import 'package:indar_deco/domain/usecases/review_usecases/get_all_reviews_usecase.dart';
import 'package:indar_deco/domain/usecases/review_usecases/remove_review.dart';
import 'package:indar_deco/domain/usecases/review_usecases/update_review_usecase.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class ReviewController extends GetxController{
 XFile? img,updateimg;
  File? f,updatef;
  final ImagePicker _picker = ImagePicker();
  String fileName = '';
  String comment = '';
   String updatefileName='';
    String updatecomment = '';
   final TextEditingController updateeditingController=TextEditingController();
   final TextEditingController editingController=TextEditingController();
  List<Review> allreviews=[]; 
  List<User> reviewUsers=[];


  final  expandableController = ExpandableController();
  bool expanded=false;

void toggleCommentSection(){
  expandableController.toggle();
  expanded = !expanded;
  update([ControllerID.TOGGLE_COMMENT]);
}

User getReviewUser(String userId)=>reviewUsers.firstWhere((element) => element.id==userId);
Future<List<Review>> getProductReviews()async{
  ProductController productController=Get.find();
  final res =await GetAllReviewsUsecase(sl())(productController.currentProductid);
  res.fold((l) => null, (r) => allreviews=r);
  for (var element in allreviews) {
   final res= await GetUserUsecase(sl())(element.userID);
    res.fold((l) => null, (r) => reviewUsers.add(r));
  }
  return allreviews;
}
  void typeComment(String s) {
    comment = s;
    update();
  }

//add new comment
  Future<void> pickImageFromGallery(BuildContext context) async {
  img = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (img != null) {
                            f = File(img!.path);
                            fileName = basename(f!.path);
                          update();
                          }
  }
  Future<void> pickImageFromCamera(BuildContext context) async {
 img = await _picker.pickImage(
                              source: ImageSource.camera);
                          if (img != null) {
                            f = File(img!.path);
                            fileName = basename(f!.path);
                          update();
                          }
  }

//update comment
Future<void> pickImageFromGalleryUpdate(BuildContext context)async{
  updateimg = await _picker.pickImage(
                                                  source: ImageSource.gallery);
                                              if (updateimg != null) {
                                                  updatef = File(updateimg!.path);
                                                  updatefileName = basename(updatef!.path);
                                              }
                                              update();
}
Future<void> pickImageFromCameraUpdate(BuildContext context)async{
   updateimg = await _picker.pickImage(
                                                  source: ImageSource.camera);
                                              if (updateimg != null) {
                                                
                                                   updatef = File(updateimg!.path);
                                                   updatefileName = basename(updatef!.path);
                                              }
                                              update();
}
void clearUpdateFile(){
  updatef = null;
  updateimg = null;
  updatefileName = '';
  update();
}
Future<void> updateComment(Review newReview,String newComment)async{
    if (newComment != '') {
                                newReview.comment = newComment;
                                if(updatefileName==''){
                                  newReview.image='';
                                }
                                await UpdateReviewUsecase(sl())(newReview)
                                    .then((value) async {
                                      if(updatef!=null){
                                         return await AddReviewImageUsecase(sl())(reviewId: newReview.id!,file: updatef!);
                                      }
                                     
                                    });
                                    update();
                                   
                              }
}

    //Clear image
void clearImage() {
    f = null;
    img = null;
    fileName = '';
    update();
  }

Future<void> addReview()async{
    AuthenticationController authenticationController=Get.find();
    ProductController productController=Get.find();

     await AddReviewUsecase(sl())
                                          .call(Review(
                                              id: null,
                                              userID: authenticationController.currentUser.id!,
                                              productID: productController.currentProductid,
                                              comment: comment.trim(),
                                              image: fileName))
                                          .then((value) async{
                                            if(f!=null){
                                           value.fold((l) => null, (r)async =>await AddReviewImageUsecase(sl())(reviewId: r.id!,file: f!) );
                                            }
                                        comment='';
                                        clearImage();
                                          await getProductReviews();
                                        editingController.clear();
                                                                             update();

                                     });

  }
Future<void> deletComment(String commentID) async {
    final deleteRes = await RemoveReviewUsecase(sl()).call(commentID);
    deleteRes.fold((l) => null, (r)async {
     await getProductReviews();
      update();
    });
  }


}