import 'package:flutter/material.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';

class WatermarkContainer extends StatelessWidget {
  final icon;
  final isSelected;
  final onTap;

  const WatermarkContainer(
      {Key? key,
      required this.icon,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical : isSelected ? 2.0 : 5),
        child: Container(
          margin:  EdgeInsets.all(5.r),
          padding:  EdgeInsets.all(10.r),
          width: 100,
          height: isSelected ? 25 : 20,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  width: 1,
                  color: isSelected ? Colors.blue : Colors.grey.withOpacity(.5))),
          child: Image.asset(icon,),
        ),
      ),
    );
  }
}
