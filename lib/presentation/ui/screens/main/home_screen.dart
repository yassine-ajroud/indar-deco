import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/presentation/controllers/main_screen_controller.dart';
import 'package:indar_deco/presentation/controllers/product_controller.dart';
import 'package:indar_deco/presentation/controllers/promotion_controller.dart';
import 'package:indar_deco/presentation/controllers/supplier_controller.dart';
import 'package:indar_deco/presentation/ui/screens/product/filtered_product_screen.dart';
import 'package:indar_deco/presentation/ui/widgets/app_bar/main_sliver_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:indar_deco/presentation/ui/widgets/product/products_grid_item.dart';
import 'package:indar_deco/presentation/ui/widgets/product/products_item.dart';
import 'package:indar_deco/presentation/ui/widgets/product/promotion_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 late final SupplierController supplierController;
 late final MainScreenController mainScreenController;
 late final ScrollController scrollController;
late final TextEditingController searchController;

  @override
  void initState() {
   supplierController = Get.find();
   mainScreenController =Get.find();
   scrollController = ScrollController(initialScrollOffset:mainScreenController.homeScrollPosition);
   searchController = TextEditingController();
    super.initState();
  }

@override
  void dispose() {
   scrollController.dispose();
   searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(
      body: RefreshIndicator(
         color: AppColors.secondary,
          onRefresh: () async{
            final ProductController c= Get.find();
            final PromotionController p=Get.find();
            c.allProducts=[];
            c.sortedProducts=[];
            p.promotionsList=[];
            setState(() {
              
            });
          },
        child: GetBuilder<ProductController>(
          init: ProductController(),
          id: ControllerID.PRODUCT_FILTER,
          builder:(pc)=>CustomScrollView(
            controller: scrollController..addListener(() {mainScreenController.homeScrollPosition=scrollController.offset;
        }),
            slivers:  pc.searchController.text==""? [
            MainSliverAppBar(title: AppLocalizations.of(context)!.discover,
            textEditingController:  pc.searchController,
            onChanged: (v){
              pc.filterProducts(v!);
                                      
            },),
            
            SliverToBoxAdapter(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           const SizedBox(height:10),
                            Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0 , vertical: 2),
                            child: Text(AppLocalizations.of(context)!.our_promotions,style: AppTextStyle.blackTitleTextStyle,),
                          ),
                         const SizedBox(height: 10,),
                         GetBuilder<PromotionController>(
                          init:PromotionController(),
                           builder:(promotionController)=> FutureBuilder(
                             future: promotionController.getAllPromotions(),
                             builder: (context, snapshot) {
                              if(snapshot.hasData){
                               return promotionController.promotionsList.isEmpty?const Center(child: Text('no promotions')) :CarouselSlider.builder(
                                
                                    options: CarouselOptions(height: 200.h,
                           viewportFraction: 0.9,
            aspectRatio: 0.5,
                                    enableInfiniteScroll :false,
                                    autoPlay :true,
                                    enlargeCenterPage: true,
                                    autoPlayInterval :const Duration(seconds: 3)
                                    ),
              itemCount: promotionController.promotionsList.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
             return  PromotionWidget(image:promotionController.promotionsList[itemIndex].image,text:promotionController.promotionsList[itemIndex].text,percentage: promotionController.promotionsList[itemIndex].discount,);
              }
            );
                              }else if(snapshot.connectionState==ConnectionState.waiting)  {
                                      return const Center(child:CircularProgressIndicator());
            
                              }else{
                              return const Text('error');
                             }
                               
                             }
                           ),
                         ),
                                ]),),
              
              
                  SliverToBoxAdapter(
                            child: Padding(
                             padding: const EdgeInsets.only(right: 15,left: 15,top:30,bottom: 5),
                             child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text(AppLocalizations.of(context)!.top_sales,style: AppTextStyle.blackTitleTextStyle,),
                              InkWell(
                                onTap:(){
                                                              final ProductController pc=Get.find();
                               Navigator.of(context).push(MaterialPageRoute(builder: (_)=>FilteredProductScreen(products:pc.sortedProducts)));
                                },
                                child: Text(AppLocalizations.of(context)!.see_all,style: AppTextStyle.smallGreyTextStyle,)),
                                    ]),
                                         ),
                          ) ,
                             SliverToBoxAdapter(
                      child: SizedBox(
                        height: 235.h,
                        child: GetBuilder<ProductController>(
                          init:ProductController(),
                          builder:(productController)=> FutureBuilder(
                            future: productController.getSortedProducts(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData){ 
                                return ListView.builder(
                                padding:const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                                scrollDirection: Axis.horizontal,
                                itemCount: productController.sortedProducts.length,
                                itemBuilder: (context, index) {
                                  return ProductItem(image:productController.sortedProducts[index].image,
                                  supplier: supplierController.productSupplier(productController.sortedProducts[index].provider),
                                  name:productController.sortedProducts[index].name ,
                                  price: productController.sortedProducts[index].price,
                                  promo:productController.sortedProducts[index].promotion ,
                                  id:productController.sortedProducts[index].id! ,
                                  rating: productController.sortedProducts[index].rate,
                                  reference: productController.sortedProducts[index].reference,
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
              
              
                  SliverToBoxAdapter(
                    child:    Padding(
                             padding: const EdgeInsets.only(right: 15,left: 15,top:15,bottom: 8),
                            child: Text(AppLocalizations.of(context)!.all_products,style: AppTextStyle.blackTitleTextStyle,),
                          ),
                  ),
               SliverPadding(padding:  const EdgeInsets.symmetric(horizontal:15),
                      sliver:GetBuilder(
                          init: ProductController(),
                          builder: (productController) {
                            return FutureBuilder(
                              future:productController.getAllProducts(),
                              builder: (context, snapshot) {
                                return SliverGrid(
                                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 0.8,
                                      ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return ProductGridItem(image:productController.allProducts[index].image,
                                      supplier: supplierController.productSupplier(productController.allProducts[index].provider),
                                      name:productController.allProducts[index].name ,
                                      price: productController.allProducts[index].price,
                                      promo:productController.allProducts[index].promotion ,
                                      id:productController.allProducts[index].id! ,
                                      rating: productController.allProducts[index].rate,
                                      reference: productController.allProducts[index].reference,
                                      );
                                  },
                                  childCount:productController.allProducts.length
                            
                                ),
                                );
                              }
                            );
                          }
                        ) ,
          ) ,
              
             const  SliverToBoxAdapter(
                        child: SizedBox(height: 10),
                      )
        
        
        
        
          ]:[
            MainSliverAppBar(title: AppLocalizations.of(context)!.discover,
                      textEditingController:  pc.searchController,
        
            onChanged: (v){
              pc.filterProducts(v!);
            }),
        
                 
               SliverPadding(padding:  const EdgeInsets.symmetric(horizontal:15),
                      sliver:GetBuilder(
                          init: ProductController(),
                          builder: (productController) {
                            return FutureBuilder(
                              future:productController.getAllProducts(),
                              builder: (context, snapshot) {
                                return SliverGrid(
                                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 0.8,
                                      ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return ProductGridItem(image:productController.filtredProducts[index].image,
                                      supplier: supplierController.productSupplier(productController.filtredProducts[index].provider),
                                      name:productController.filtredProducts[index].name ,
                                      price: productController.filtredProducts[index].price,
                                      promo:productController.filtredProducts[index].promotion ,
                                      id:productController.filtredProducts[index].id! ,
                                      rating: productController.filtredProducts[index].rate,
                                      reference: productController.filtredProducts[index].reference,
                                      );
                                  },
                                  childCount:productController.filtredProducts.length
                            
                                ),
                                );
                              }
                            );
                          }
                        ) ,
          ) ,
              
             const  SliverToBoxAdapter(
                        child: SizedBox(height: 10),
                      )
          ]
          
          ),
        ),
      ),
    )
    );
  }
}