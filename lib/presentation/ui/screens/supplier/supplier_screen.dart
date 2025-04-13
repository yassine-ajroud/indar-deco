import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/presentation/controllers/supplier_controller.dart';
import 'package:indar_deco/presentation/ui/widgets/app_bar/supplier_slver_app_bar.dart';
import 'package:indar_deco/presentation/ui/widgets/product/products_grid_item.dart';

class SupplierScreen extends StatelessWidget {
  const SupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: GetBuilder(
        init:SupplierController(),
        builder: (controller) {
          return FutureBuilder(
            future: controller.getSupplierById(controller.selectedSupplierId),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return CustomScrollView(slivers: [SupplierSliverAppBar(supplier: snapshot.data!,products: controller.getSupplierProducts(snapshot.data!.id).length,),
               
                    SliverToBoxAdapter(
                  child: SizedBox(
                    height: 45.h,
                    child: GetBuilder<SupplierController>(
                      id:ControllerID.SELECT_SUPPLIER_CATEGORY,
                      init:SupplierController(),
                      builder:(categoryController)=> FutureBuilder(
                        future: controller.supplierCategories(controller.selectedSupplierId),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){ 
                            return
                                 ListView.builder(
                                padding:const EdgeInsets.symmetric(horizontal:12,vertical: 5),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.tousCategories.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                    child: GestureDetector(
                                      onTap:(){
                                       controller.selectCategory(snapshot.data![index]);
                                      },
                                      child: Container(
                                        decoration:snapshot.data![index]==controller.selectedCategory? BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius:BorderRadius.circular(20),
                                           border:  Border.all(
                                          color: AppColors.primary, 
                                          width: 1.5,
                                        ),
                                        ):BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:BorderRadius.circular(20),
                                          border:  Border.all(
                                          color: AppColors.black, 
                                          width: 1.5,
                                        ),
                                        ) ,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:15,vertical: 8.0),
                                          child: Text( snapshot.data![index].title,
                                          style:
                                          controller.selectedCategory==snapshot.data![index]?
                                           AppTextStyle.smallWhiteTextStyle:  AppTextStyle.smallBlackTextStyle,),
                                          ),
                                        ),
                                      ),
                                  
                                  );
                                },
                          );
                              
                            
                          }else if(snapshot.connectionState==ConnectionState.waiting)  {
                                  return const Center(child:CircularProgressIndicator());
        
                          }else{
                          return const Text('error');
                         }             
                        }
                      ),
                    ),
                  ),
                ),

                
                SliverPadding(
                  padding:const EdgeInsets.all(15),
                  sliver: GetBuilder(
                    init: SupplierController(),
                      id:ControllerID.SELECT_SUPPLIER_CATEGORY,
                    builder: (controller) {
                      return SliverGrid(
                                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                              childAspectRatio: 0.8,
                                            ),
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          return ProductGridItem(image:controller.selectedProducts[index].image,
                                            supplier: controller.selectedProducts[index].provider,
                                            name:controller.selectedProducts[index].name ,
                                            price: controller.selectedProducts[index].price,
                                            promo:controller.selectedProducts[index].promotion ,
                                            id:controller.selectedProducts[index].id! ,
                                            rating: controller.selectedProducts[index].rate,
                                            reference: controller.selectedProducts[index].reference,
                                            );
                                        },
                                        childCount:controller.selectedProducts.length
                                  
                                      ),
                      );
                    }
                  ),
                )
                ],); 
              }else if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }  return const Text('error');
    
            }
          );
        }
      ),
    ),);
  }
}