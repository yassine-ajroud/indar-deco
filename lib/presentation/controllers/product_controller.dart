import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/di.dart';
import 'package:indar_deco/domain/entities/product.dart';
import 'package:indar_deco/domain/entities/product3D.dart';
import 'package:indar_deco/domain/usecases/product_3d_usecases/get_all_3d_products_usecase.dart';
import 'package:indar_deco/domain/usecases/product_usecases/get_all_products_usecase.dart';
import 'package:indar_deco/domain/usecases/product_usecases/get_one_product_usecase.dart';
import 'package:indar_deco/domain/usecases/product_usecases/get_products_by_subcategory_usecase.dart';
import 'package:indar_deco/domain/usecases/product_usecases/get_sorted_products_usecase.dart';
import 'package:indar_deco/presentation/controllers/promotion_controller.dart';
import 'package:indar_deco/presentation/controllers/supplier_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductController extends GetxController {
  List<Product> allProducts=[];
  List<Product> sortedProducts=[];
  List<Product> filtredProducts=[];
  List<Product> productsByCategory=[];
  List<Product> similarProducts=[];
  List<Product3D> productColors=[];
  late Product currentProduct;
  late Product3D selected3Dproduct;
  String currentProductid="";
  int quantity=1;
  UniqueKey textureKey=UniqueKey();
  TextEditingController searchController = TextEditingController(); 
  final SupplierController supplierController= Get.find();

  Future<List<Product>> getAllProducts()async{ 
   if(allProducts.isEmpty){
      final res = await GetAllProductsUsecase(sl())();
    res.fold((l) => null, (r) => allProducts=r);
    productsByCategory=allProducts;
    if(supplierController.suppliers.isEmpty){
      print('get all sup');
      await supplierController.getAllSupppliers();
    }
   }
    return allProducts;
  }

  Future<List<Product>> getSortedProducts()async{ 
    if(sortedProducts.isEmpty){
        final res = await GetSortedProductsUsecase(sl())();
    res.fold((l) => null, (r) => sortedProducts=r);
        if(supplierController.suppliers.isEmpty){
      await supplierController.getAllSupppliers();
    }
    }
    return sortedProducts;
  }

  Future<List<Product>> getProductsByCategory(String category)async{ 
   return allProducts.where((element) => element.category==category).toList();
  }


  Future<List<Product>> getProductsBySubCategory(String category,String subCategory,String prodId)async{ 
     final res = await GetProductsBySubCategoryUsecase(sl())(category,subCategory);
    res.fold((l) => null, (r) => similarProducts=r);
    similarProducts=similarProducts.where((element) => element.id!=prodId).toList();
    return similarProducts;
  }
set setProductId(String id)=>currentProductid =id;
  
Future<Product?> getProductsById(String id)async{ 
     final res = await GetOneProductsUsecase(sl())(id);
     final txtr= await GetAll3DProductsUseCase(sl()).call(id);
    res.fold((l) => null, (r) => currentProduct=r);
    txtr.fold((l) => null, (r) => productColors = r);
     quantity=1;
    selected3Dproduct=productColors[0];
    return currentProduct;
  }

void selectTexture(Product3D new3DProduct){
  //WishListController wishlist = Get.find();
  selected3Dproduct=new3DProduct;
  textureKey = UniqueKey();
   quantity=1;
  // wishlist.likedProduct(new3DProduct.id);
  update([ControllerID.PRODUCT_TEXTURE]);
}

  void filterProducts(String word){
    List<Product> prd=allProducts;
    filtredProducts= prd.where((element) => (element.name.toUpperCase().contains(word.toUpperCase()))).toList();
    update([ControllerID.PRODUCT_FILTER]);
  }
//  @override
//   void onInit() async{
//     super.onInit();
//   await getAllProducts();
//   productsByCategory=allProducts;
//   }

  void incrementQuantity(){
    if(quantity<selected3Dproduct.quantity){
   quantity++;
  update([ControllerID.PRODUCT_TEXTURE]);
    }

  }
    void decrementQuantity(){
  if(quantity>1){
   quantity--;
  update([ControllerID.PRODUCT_TEXTURE]);
    }
}

double getPrice(Product product){
  PromotionController promoController= Get.find();
  if(product.promotion){
  return  promoController.promotionsList.firstWhere((element) => element.product==product.id).newPrice;
  }
  return product.price;
}

String getProductDimensions(LocalDimensions dimensions,BuildContext context){
  String res='';
  String res2='';
  if(dimensions.length!=null){
    res+='${dimensions.length}${AppLocalizations.of(context)!.cm} x ';
    res2+='L x ';
  }  if(dimensions.width!=null){
    res+='${dimensions.width}${AppLocalizations.of(context)!.cm} x ';
    res2+='W x ';
  }
   if(dimensions.height!=null){
    res+='${dimensions.height}${AppLocalizations.of(context)!.cm} x ';
    res2+='H x ';
  } if(dimensions.radius!=null){
    res+='${dimensions.radius}${AppLocalizations.of(context)!.cm}';
    res2+='R';
  }
  if(res[res.length-1]==' '){
    res = res.substring(0, res.length - 3);
     res2= res2.substring(0, res2.length - 3);

  }
  res2='($res2)';
  return '$res $res2';
}

}