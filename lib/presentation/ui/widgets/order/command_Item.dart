import 'package:flutter/material.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:intl/intl.dart';

class CommandItem extends StatelessWidget {
  final int index;
  final String reference;
  final DateTime date;
  final double price;
  const CommandItem({super.key,required this.index,required this.date,required this.reference, required this.price});

  @override
  Widget build(BuildContext context) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return Padding(
        padding: const EdgeInsets.symmetric(vertical:3.0,horizontal: 20),
      child: Container(
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
        child: Padding(
        padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Commande N°$index',style: AppTextStyle.subTitleTextStyle,),
              Text(formatter.format(date),style: AppTextStyle.smallGreyTextStyle,)
            ],),
            Text('ref: $reference',style: AppTextStyle.smallGreyTextStyle,),
            Text('Total price: ${price.toString()}DT',style: AppTextStyle.smallGreyTextStyle,),


          ]),
        ),
      ),
    );
  }
}