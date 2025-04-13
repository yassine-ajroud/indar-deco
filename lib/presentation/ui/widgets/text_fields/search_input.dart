import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/core/utils/svg.dart';


// ignore: must_be_immutable
class SearchInput extends StatefulWidget {
  final String hint;
   bool ? isPassword;
  final String? leading; 
  final String? Function(String?)? validator;
    final void Function(String?)? onChanged;
  final TextEditingController? controler;
  final int ? length;
  final TextInputType ? type ;
   SearchInput({super.key, required this.hint,this.isPassword,this.type,this.controler,this.validator,this.length, this.leading,this.onChanged});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
 late bool obs;
 late String icon ;
  @override
  void initState() {
    obs=widget.isPassword??false;
    icon =APPSVG.visibleIcon;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow:const [
      BoxShadow(
        color: AppColors.lightShadow,
        spreadRadius: 1,
        blurRadius: 8,
        offset: Offset(0, 4), // changes position of shadow
      ),
    ],
      ),
      child: TextFormField(
        maxLength: widget.length,
        validator: widget.validator,
        controller: widget.controler,
        onChanged: widget.onChanged,
      obscureText: obs ,
      keyboardType: widget.type ?? TextInputType.text,
        decoration: InputDecoration(
          contentPadding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none),
          fillColor: AppColors.white,
          filled: true,
          
          hintText:widget.hint,
              suffixIcon: 
              // ignore: deprecated_member_use
              SvgPicture.string(APPSVG.searchIcon,color: AppColors.hintColor,fit: BoxFit.scaleDown,
             ),
            hintStyle: AppTextStyle.hintTextStyle
            
      )),
    );
  }
}