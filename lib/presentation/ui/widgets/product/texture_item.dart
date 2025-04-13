import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indar_deco/core/utils/string_const.dart';
import 'package:indar_deco/domain/entities/product3D.dart';
import '../../../controllers/product_controller.dart';

class TextureItem extends StatelessWidget {
  final Product3D product;
  const TextureItem({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: ProductController(),
      id:ControllerID.PRODUCT_TEXTURE,
      builder: (controller) {
       final isSelected = controller.selected3Dproduct.id==product.id;
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: (){
              controller.selectTexture(product);
            },
            child: 
            CircleAvatar(backgroundImage:NetworkImage(product.texture),radius: isSelected?22:18,)
            
          ),
        );
      }
    );
  }
}