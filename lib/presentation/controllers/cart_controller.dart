import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/di.dart';
import 'package:indar_deco/domain/entities/cart.dart';
import 'package:indar_deco/domain/entities/product3D.dart';
import 'package:indar_deco/domain/entities/sales.dart';
import 'package:indar_deco/domain/usecases/cart_usecases/create_cart_usecase.dart';
import 'package:indar_deco/domain/usecases/cart_usecases/get_cart_usecase.dart';
import 'package:indar_deco/domain/usecases/cart_usecases/update_cart_usecase.dart';
import 'package:indar_deco/domain/usecases/product_3d_usecases/get_3d_product_by_id_usecase.dart';
import 'package:indar_deco/domain/usecases/sales_usecases/add_sale_usecase.dart';
import 'package:indar_deco/domain/usecases/sales_usecases/delete_sale_usecase.dart';
import 'package:indar_deco/domain/usecases/sales_usecases/get_single_sale_usecase.dart';
import 'package:indar_deco/domain/usecases/sales_usecases/update_sale_usecase.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';


class CartController extends GetxController{
late  Cart currentCart;
List<Sales> cartSales=[];
List<Product3D> cartProducts=[];
double totalPrice=0.0;
// ignore: non_constant_identifier_names
var shipping_fee=8.0;


Future<Cart> getUserCart(String userId)async{
cartSales=[];
cartProducts=[];
 final res= await GetCartUsecase(sl())(userId: userId);
 res.fold((l) => null, (r) =>currentCart=r );
 await getCartSales();
 await getCartProducts();
 getReclamationPrice();
 return currentCart;
}

Future<void> getCartProducts()async{
  cartProducts=[];
  for (var element in getCartmodelId) {
    final res = await Get3DProductsByIdUseCase(sl())(element);
    res.fold((l) => null, (r)async {
      final s=cartSales.firstWhere((e) => e.modelId==element);

      if(r.quantity<s.quantity || r.quantity <1){
          cartSales.firstWhere((e) => e.modelId==element).quantity=0;
       
                        // print(productController.getPrice(prods.firstWhere((elm) => elm.id==r.product)));

     //    cartSales.firstWhere((e) => e.modelId==element).totalPrice=r.quantity*productController.getPrice(prods.firstWhere((elm) => elm.id==s.productId));
        //await UpdateSaleUsecase(sl())( cartSales.firstWhere((e) => e.modelId==element));
      }
      cartProducts.add(r);
    });
  }
}

Future<void> incrementSaleQuantity(String saleId)async{
  final ProductController productController = Get.find();
final Sales sale=cartSales.firstWhere((element) => element.id==saleId);
  if(sale.quantity<cartProducts.firstWhere((element) => sale.modelId==element.id).quantity){
  sale.quantity++;
    sale.totalPrice=double.parse( (productController.getPrice(productController.allProducts.firstWhere((element) => element.id==sale.productId))*sale.quantity).toStringAsFixed(2)) ;
  await UpdateSaleUsecase(sl())(sale);
  }
   getReclamationPrice();
  update([ControllerID.SALE_QUANTITY]);
}
Future<void> decrimentSaleQuantity(String saleId)async{
  final ProductController productController = Get.find();

final Sales sale=cartSales.firstWhere((element) => element.id==saleId);
  if(sale.quantity>1){
  sale.quantity--;
    sale.totalPrice=double.parse( (productController.getPrice(productController.allProducts.firstWhere((element) => element.id==sale.productId))*sale.quantity).toStringAsFixed(2)) ;
  await UpdateSaleUsecase(sl())(sale);
  }
   getReclamationPrice();

  update([ControllerID.SALE_QUANTITY]);
}

Future<void> addUserCart(String userId)async{
 await CreateCartUsecase(sl())(userId: userId);
}

Future<void> updateUserCart(Cart newCart)async{
 await UpdateCartUsecase(sl())(cart: newCart);
}

Future<List<Sales>> getCartSales()async{
  cartSales=[];
  for (var element in currentCart.productsId) {
       final  res = await GetSingleSalesUsecase(sl())(element);
   res.fold((l) => null, (r) {
     cartSales.add(r);
   }); 
  }

  return cartSales;
}


 List<String> get getCartSalesId=> cartSales.map((e) => e.id!).toList();
  List<String> get getCartmodelId=> cartSales.map((e) => e.modelId).toList();

 
 Future addSale(Sales newSale)async{
  print('sales tracking add sale${newSale.modelId}');
  if(!getCartmodelId.contains(newSale.modelId)){
    final addsale = await AddSaleUsecase(sl()).call(newSale);
    addsale.fold((l) => null, (r) async{
      cartSales.add(r);
      await _updateSailes();
    });
  }else{
     Fluttertoast.showToast(
            msg: 'product already in cart!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.black,
            textColor: AppColors.white,
            fontSize: 16.0);
  }
  await getUserCart(newSale.userId);
  update();
 }

void getReclamationPrice(){
  double sum=0.0;
  for (var sale in cartSales) {
    if(sale.quantity>0) {
      sum+=sale.totalPrice;
    }
  }
  totalPrice= sum+shipping_fee;
}

Future _updateSailes()async{
  currentCart.productsId=getCartSalesId;
  await UpdateCartUsecase(sl()).call(cart: currentCart);
  update();
}

Future deleteSale(String saleId)async{
  await DeleteSaleUsecase(sl()).call(saleId); 
  cartSales.removeWhere((element) => element.id==saleId);
  currentCart.productsId=getCartSalesId;
  await _updateSailes();
  await getUserCart(currentCart.userId);
  update();
}

Future clearCart()async{
 cartSales=[];
 await _updateSailes();
}

}