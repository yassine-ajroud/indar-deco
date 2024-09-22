import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SVGIconButton extends StatelessWidget {
  final String icon;
  const SVGIconButton({super.key,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SvgPicture.string(icon),
    );
  }
}