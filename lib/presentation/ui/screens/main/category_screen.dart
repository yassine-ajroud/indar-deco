import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/presentation/controllers/category_controller.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';
import 'package:indar_deco/presentation/ui/screens/product/filtered_product_screen.dart';
import 'package:indar_deco/presentation/ui/widgets/app_bar/main_sliver_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:indar_deco/presentation/ui/widgets/category/category_item.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.background,
      body: GetBuilder(
        init: CategoryController(),
        id: ControllerID.CATEGORY_FILTER,
        builder: (controller) {
          return FutureBuilder(
            future: controller.loadCategories(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
 return RefreshIndicator(
  onRefresh: ()async{
    controller.categoriesList=[];
    setState(() {
      
    });
  },
   child: CustomScrollView(
                  slivers: [
                          MainSliverAppBar(title:AppLocalizations.of(context)!.categories, onChanged: (v){
                            controller.filterCategories(v!);
                          }),
 
                        SliverPadding(padding:  const EdgeInsets.symmetric(horizontal:15),
                        sliver: SliverGrid(
                                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 2,
                                      childAspectRatio: 0.95,
                                    ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return InkWell(
                                    onTap:() async{
                                          final ProductController productController=Get.find();
                                      final prods=await productController.getProductsByCategory( controller.filtredCategoriesList[index].id);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>FilteredProductScreen(products:prods)));
                                    },
                                    child: CategoryItem(category: controller.filtredCategoriesList[index]));
                                },
                                childCount: controller.filtredCategoriesList.length,
                              ),
                              )
            ) ,
                const  SliverToBoxAdapter(
                              child: SizedBox(height: 10),
                            )
         
                  ],
                ),
 );
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
             
            }
          );
        }
      ),
    ));
  }
}
