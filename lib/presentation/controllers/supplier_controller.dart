import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:indar_deco/di.dart';
import 'package:indar_deco/domain/entities/supplier.dart';
import 'package:indar_deco/domain/usecases/supplier_usecases/get_all_suppliers_usecase.dart';
import 'package:indar_deco/domain/usecases/supplier_usecases/get_supplier_by_ud_usecase.dart';


class SupplierController extends GetxController{
 late Supplier currentSupplier;
 List<Supplier> suppliers=[];
  

  Future<Supplier?> getSupplierById(String supplierId)async{
   final res= await GetSupplierByIdUsecase(sl())(supplierId);
   res.fold((l) => null, (r) => currentSupplier=r );
   return currentSupplier;
  }

  Future getAllSupppliers()async{
    print('get suppliers');
    final res =await GetSuppliersUsecase(sl())();
    res.fold((l) => null, (r) => suppliers=r);
  }

  String productSupplier(String supplierID)=>suppliers.firstWhere((element) => element.id==supplierID).marque;
}