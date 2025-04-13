import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:indar_deco/domain/entities/reclamation.dart';
import 'package:indar_deco/domain/usecases/reclamation_usecases/get_all_reclamations_usecase.dart';
import 'package:indar_deco/presentation/controllers/authentication_controller.dart';


import '../../../di.dart';

class RaclamationsController extends GetxController{
  List<Reclamation> commands=[];
  late Reclamation currentReclamation;


  Future<bool> getCommands() async{
    final AuthenticationController authenticationController = Get.find();
    final res = await GetAllReclamationsUsecase(sl()).call(authenticationController.currentUser.id!);
    res.fold((l) => null, (r) => commands=r);
    return true;
  }

  void selectReclamation(Reclamation rec){
    currentReclamation= rec;
  }

}