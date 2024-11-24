import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/domain/entities/product.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';
import 'package:indar_deco/presentation/controllers/supplier_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/product/products_grid_item.dart';
import 'package:indar_deco/presentation/ui/widgets/text_fields/search_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


// ignore: must_be_immutable
class FilteredProductScreen extends StatefulWidget {
  List<Product> products=[];
   FilteredProductScreen({super.key,required this.products});

  @override
  State<FilteredProductScreen> createState() => _FilteredProductScreenState();
}
late  TextEditingController  editingController;
List<Product> filteredList=[];

class _FilteredProductScreenState extends State<FilteredProductScreen> {
  late final ProductController productController;
  late final SupplierController supplierController;

  @override
  void initState() {
    editingController = TextEditingController();
    productController = Get.find();
    supplierController = Get.find();
    filteredList=widget.products;
    super.initState();
  }
  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
                      automaticallyImplyLeading: false,
                 shadowColor: AppColors.lightShadow,
                        expandedHeight: 133.h,
                        pinned: true,
                        floating: true,
                        snap: true,
                        leading:IconButton(
                    onPressed: (){
                    Navigator.of(context).pop();
                  }, 
                  padding: EdgeInsets.zero,
                  icon:const Icon(Icons.arrow_back,size: 30,)) ,
                        flexibleSpace:FlexibleSpaceBar(
                  background: Padding(
                        padding: const EdgeInsets.symmetric(vertical:20,horizontal: 15),
                    child: Builder(
                      builder: (ctx) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:[
                                 SearchInput(
                                  hint: AppLocalizations.of(context)!.search,
                                onChanged: (v){
                                  setState(() {
                                    filteredList=widget.products.where((element) => element.name.toUpperCase().contains(v!.toUpperCase())||element.description.toUpperCase().contains(v.toUpperCase())).toList();
                                  });
                                },),
    
                              
                              ],
                            );
                          
                      }
                    ),
                  ),
                ),
                ),   
    
                  SliverPadding(padding:  const EdgeInsets.symmetric(horizontal:15),
                sliver:
                       SliverGrid(
                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return ProductGridItem(image: filteredList[index].image, name:  filteredList[index].name, price:  filteredList[index].price, id:  filteredList[index].id!, rating:  filteredList[index].rate,
                          reference:filteredList[index].reference, supplier: supplierController.productSupplier(productController.sortedProducts[index].provider),

                          );
                        },
                        childCount: filteredList.length,
                      ),
                      )
                    
         
    ) ,
        ],
      ),
    );
  }
}