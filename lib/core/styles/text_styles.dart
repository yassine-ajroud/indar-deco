import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class AppTextStyle {
 static TextStyle darkLabelTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: AppColors.darkGrey2,fontFamily: 'Alata');
 static TextStyle supplierNameTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp, color: AppColors.grey,fontFamily: 'Alata');
 static TextStyle ratingTextStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 30.sp, color: AppColors.primary,fontFamily: 'Alata');
 static TextStyle lightLabelTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 13.sp, color: AppColors.grey,fontFamily: 'Alata');
 static TextStyle titleTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 30.sp, color: AppColors.darkGrey,fontFamily: 'Alata');
 static TextStyle blueLabelTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp, color: AppColors.primary,fontFamily: 'Alata');
  static TextStyle blueTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp, color: AppColors.primary,fontFamily: 'Alata');
 static TextStyle hintTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: AppColors.hintColor,fontFamily: 'Alata');
 static TextStyle boldGreyTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: AppColors.hintColor,fontFamily: 'Alata');
 static TextStyle outOfStockTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp, color: AppColors.red,fontFamily: 'Alata');
 static TextStyle onStockTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp, color: AppColors.green,fontFamily: 'Alata');
 static TextStyle buttonTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: AppColors.white,fontFamily: 'Alata');
 static TextStyle blackTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 13.sp, color: AppColors.black,fontFamily: 'Alata');
 static TextStyle descriptionTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: AppColors.darkGrey2,fontFamily: 'Alata',);
 static TextStyle appBarTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, color: AppColors.black,fontFamily: 'Alata');
 static TextStyle blackTitleTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: AppColors.black,fontFamily: 'Alata');
 static TextStyle greyTitleTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 15.sp, color: AppColors.darkGrey,fontFamily: 'Alata');
 static TextStyle normalTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: AppColors.black);
 static TextStyle promotionTextTextStyle= TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: AppColors.white,fontFamily: 'Alata',);
  static TextStyle cartBadgeTextTextStyle= TextStyle(fontWeight: FontWeight.w400, fontSize: 7.sp, color: AppColors.white,fontFamily: 'Alata',);
 static TextStyle promotiondiscountTextStyle= TextStyle(fontWeight: FontWeight.w600, fontSize: 22.sp, color: AppColors.secondary,fontFamily: 'Alata',);
 static TextStyle smallBlackTitleTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp, color: AppColors.black,fontFamily: 'Alata');
 static TextStyle priceTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp, color: AppColors.primary,fontFamily: 'Alata');
 static TextStyle mainPriceTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp, color: AppColors.primary,fontFamily: 'Alata');
 static TextStyle mainOlldPriceTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp, color: AppColors.grey,fontFamily: 'Alata',decoration: TextDecoration.lineThrough);
 static TextStyle oldPriceTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp, color: AppColors.grey,fontFamily: 'Alata',decoration: TextDecoration.lineThrough);
 static TextStyle smallGreyTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 10.sp, color: AppColors.hintColor,fontFamily: 'Alata');
 static TextStyle smallBlackTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 10.sp, color: AppColors.black,fontFamily: 'Alata');
  static TextStyle producDescTitiletTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp, color: AppColors.black,fontFamily: 'Alata');
  static TextStyle subTitleTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: AppColors.black,fontFamily: 'Alata');
 static TextStyle whiteTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: AppColors.white,fontFamily: 'Alata');
 static TextStyle descriptionBoldTextStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp, color: AppColors.darkGrey2,fontFamily: 'Alata',);
 static TextStyle smallWhiteTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 10.sp, color: AppColors.white,fontFamily: 'Alata');


  // static TextStyle titleTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp, color: AppColors.black,fontFamily: 'Montserrat');
  // static TextStyle secondaryTitleTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 36.sp, color: AppColors.darkGrey2);
  // static TextStyle whiteTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: AppColors.white,fontFamily: 'Montserrat');
  // //static TextStyle greyTitleTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 15.sp, color: AppColors.darkGrey);
  //       static TextStyle whiteTitleTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: AppColors.white,fontFamily: 'Montserrat');
  //   static TextStyle blackSettingsTitleTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, color: AppColors.black,fontFamily: 'Montserrat');
  //   static TextStyle whiteSettingsTitleTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, color: AppColors.white,fontFamily: 'Montserrat');

  //   static TextStyle blackTitleTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: AppColors.black,fontFamily: 'Montserrat');
  //   static TextStyle boldBlackTitleTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp, color: AppColors.black,fontFamily: 'Montserrat');
  //   static TextStyle descriptionTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.darkGrey2,fontFamily: 'Montserrat');
  //   static TextStyle largeBlackTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 22.sp, color: AppColors.black,fontFamily: 'Montserrat');
  //   static TextStyle smallWhiteTitleTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp, color: AppColors.white,fontFamily: 'Montserrat');
  //   static TextStyle smallGreyTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp, color: AppColors.darkGrey2,fontFamily: 'Montserrat');
  //   static TextStyle smallBlueTitleTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp, color: AppColors.secondary,fontFamily: 'Montserrat');
  //   static TextStyle smallDarkButtonTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp, color: AppColors.white,fontFamily: 'Montserrat');
  //   static TextStyle smallLightButtonTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp, color: AppColors.secondary,fontFamily: 'Montserrat');
  //   static TextStyle hintTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.hintColor,fontFamily: 'Montserrat');
 
  //   static TextStyle outOfStockTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp, color: AppColors.red,fontFamily: 'Montserrat');

  //   static TextStyle onStockTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp, color: AppColors.green,fontFamily: 'Montserrat');
  //   static TextStyle greyTitleTextStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.darkGrey,fontFamily: 'Montserrat');


  //   static TextStyle appBarTextButtonStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, color: AppColors.black,fontFamily: 'Montserrat');

  //   static TextStyle secondaryBlackTitleTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 18.sp, color: AppColors.black,fontFamily: 'Montserrat');
  //   static TextStyle smallblackTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp, color: AppColors.black,fontFamily: 'Montserrat');
  //   static TextStyle smallblackTextButtonStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp, color: AppColors.black,fontFamily: 'Montserrat');
  // static TextStyle blackTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 15.sp, color: AppColors.black,fontFamily: 'Montserrat');

  //   static TextStyle disabledTitleTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: AppColors.hintColor);
  // static TextStyle splashTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 22.sp, color: AppColors.white,fontFamily: 'Montserrat');

  // static TextStyle buttonTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: AppColors.white,fontFamily: 'Montserrat');
  // static TextStyle blueTextButtonTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp, color: AppColors.primary);
  //   static TextStyle incorrectTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: AppColors.red);


      }