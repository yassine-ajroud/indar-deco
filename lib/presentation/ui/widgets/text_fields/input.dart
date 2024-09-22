import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/utils/svg.dart';


// ignore: must_be_immutable
class InputText extends StatefulWidget {
  final String hint;
   bool ? isPassword;
  final String? leading; 
  final String? Function(String?)? validator;
  final TextEditingController? controler;
  final int ? length;
  final TextInputType ? type ;
   InputText({super.key, required this.hint,this.isPassword,this.type,this.controler,this.validator,this.length, this.leading});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
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
    return TextFormField(
      maxLength: widget.length,
      validator: widget.validator,
      controller: widget.controler,
    
    obscureText: obs ,
    keyboardType: widget.type ?? TextInputType.text,
      decoration: InputDecoration(
        errorBorder: const UnderlineInputBorder(      
                      borderSide: BorderSide(color:AppColors.red),   
                      ),
        enabledBorder: const UnderlineInputBorder(      
                      borderSide: BorderSide(color:AppColors.grey),   
                      ),  
              focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                   ),  
        contentPadding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(35),borderSide: BorderSide.none),
        filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: AppColors.white.withOpacity(0.3),
        hintText:widget.hint,
        prefixIcon:widget.leading==null?null:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SvgPicture.string(widget.leading!,
              fit: BoxFit.scaleDown),
        ) ,
            suffixIcon: widget.isPassword??false ?InkWell(onTap:(){setState(() {
              obs=!obs;
              icon=obs?APPSVG.visibleIcon:APPSVG.invisibleIcon;
              
            });}, child:SvgPicture.string(icon,fit: BoxFit.scaleDown, )):null,
          
    ));
  }
}