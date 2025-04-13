import 'package:flutter/material.dart';


class Adaptivity{
  
  static AlignmentGeometry alignmentRight(String language){
    if(language=='ar'){
    return Alignment.centerLeft;
    }else{
    return Alignment.centerRight;
    }
  }

   static AlignmentGeometry alignmentLeft(String language){
    if(language=='ar'){
    return Alignment.centerRight;
    }else{
    return Alignment.centerLeft;
    }
  }

  static EdgeInsets textFieldIconPadding(String language){
     if(language=='ar'){
    return const EdgeInsets.only(right:25.0,left: 10);
    }else{
    return const EdgeInsets.only(right:10.0,left: 25);
    }
  }

   static EdgeInsets paddingLeft(String language,double padding){
    if(language=='ar'){
    return  EdgeInsets.only(right: padding);
    }else{
    return  EdgeInsets.only(left: padding);
    }
  }

}