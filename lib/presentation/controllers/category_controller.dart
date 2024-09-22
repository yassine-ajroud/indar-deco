import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/di.dart';
import 'package:indar_deco/domain/entities/sub_catergory.dart';
import 'package:indar_deco/domain/usecases/category_usecases/get_categories_usecase.dart';
import 'package:indar_deco/domain/usecases/sub_category_usecases/get_all_sub_categories_usecase.dart';

import '../../domain/entities/category.dart';

class CategoryController extends GetxController{
  List<Category> categoriesList=[];
  List<SubCategory> subCategoriesList=[];
   List<Category> filtredCategoriesList=[];
   List<SubCategory> filtredsubCategoriesList=[];
   TextEditingController searchController = TextEditingController(); 

  Future<List<Category>> getAllCategories()async{ 
    if(categoriesList.isEmpty){
          final res = await GetAllCategoriesUsecase(sl())();
    res.fold((l) => null, (r) {
        filtredCategoriesList=r;
       categoriesList=r;
    });}
    return categoriesList;
  }

    Future<List<SubCategory>> getAllSubCategories()async{ 
    if(subCategoriesList.isEmpty){
          final res = await GetAllSubCategoriesUsecase(sl())();
    res.fold((l) => null, (r) {
        filtredsubCategoriesList=r;
       subCategoriesList=r;
    });}
      return subCategoriesList;
    }
  
  Future<bool> loadCategories()async{
    await getAllCategories();
    await getAllSubCategories();
    return true;
  }

  //   Future<List<Category>> getCategories()async{ 
  //         final res = await GetAllCategoriesUsecase(sl())();
  //   res.fold((l) => null, (r) {
  //       allCategories=r;
  //       filtredCategoriesList=r;
  //   });
  //   return filtredCategoriesList;
  // }

void filterCategories(String word){
    filtredCategoriesList= categoriesList.where((element) => (element.title.toUpperCase().contains(word.toUpperCase()))).toList();
    update([ControllerID.CATEGORY_FILTER]);
}


String getCategoryName(String categoryID){
  return categoriesList.firstWhere((element) => element.id==categoryID).title;
}

String getsubCategoryName(String subCategoryID){
  return subCategoriesList.firstWhere((element) => element.id==subCategoryID).title;
}

  @override
  void onInit() async{
    super.onInit();
    if(categoriesList.isEmpty || subCategoriesList.isEmpty){  
  await loadCategories();

    }
  }
}