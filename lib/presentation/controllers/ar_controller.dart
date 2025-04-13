import 'package:get/get.dart';

class AugmentedRealityController extends GetxController{
  double rotation=0.0;
  double slide=-200;

  void rotate(){
    if(rotation==0.0){
      rotation =1/8;
      slide=0;
    }else{
      rotation =0.0;
      slide=-200;
    }
    update();
  }
}