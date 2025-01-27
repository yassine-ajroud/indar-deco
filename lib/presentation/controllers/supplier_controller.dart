import 'package:get/get.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/di.dart';
import 'package:indar_deco/domain/entities/category.dart';
import 'package:indar_deco/domain/entities/product.dart';
import 'package:indar_deco/domain/entities/supplier.dart';
import 'package:indar_deco/domain/usecases/supplier_usecases/get_all_suppliers_usecase.dart';
import 'package:indar_deco/domain/usecases/supplier_usecases/get_supplier_by_ud_usecase.dart';
import 'package:indar_deco/presentation/controllers/category_controller.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';


class SupplierController extends GetxController{
 late Supplier currentSupplier;
 List<Supplier> suppliers=[];
 String selectedSupplierId='';
 late Category selectedCategory;
 List<Category> tousCategories=[];
 List<Product> selectedProducts=[];



 void selectSupplier(String id){
  selectedSupplierId = id;
 }
  

  Future<Supplier?> getSupplierById(String supplierId)async{
   final res= await GetSupplierByIdUsecase(sl())(supplierId);
   res.fold((l) => null, (r) => currentSupplier=r );
   return currentSupplier;
  }

  Future getAllSupppliers()async{
    final res =await GetSuppliersUsecase(sl())();
    res.fold((l) => null, (r) => suppliers=r);
  }

  String productSupplier(String supplierID)=>suppliers.firstWhere((element) => element.id==supplierID).marque;

  List<Product> getSupplierProducts(String supplierID){
    final ProductController productController = Get.find();
    return productController.allProducts.where((element) => element.provider==supplierID).toList();
  }

  Future<List<Category>> supplierCategories(String supplierID)async{
    if(tousCategories.isEmpty){
    final CategoryController categoryController = Get.find();
    List<Category> res= [Category(id: 'tous', title: 'All', image: 'image')];
     final allCategories=await categoryController.getAllCategories();
    final prods= getSupplierProducts(supplierID);
    selectedProducts=prods;
        selectCategory(res[0]);

    for (var prod in prods) {
      if(!res.contains(allCategories.firstWhere((element) => element.id==prod.category))){
      res.add(allCategories.firstWhere((element) => element.id==prod.category));
      }

    }
    tousCategories = res;
  }  
  return tousCategories;
  
} 

  void selectCategory(Category category){
    selectedCategory = category;
    if(category.id=='tous'){
    selectedProducts = getSupplierProducts(selectedSupplierId);
    }else{
      selectedProducts = getSupplierProducts(selectedSupplierId).where((element) => element.category==category.id).toList();
    }
    update([ControllerID.SELECT_SUPPLIER_CATEGORY]);
  }

}