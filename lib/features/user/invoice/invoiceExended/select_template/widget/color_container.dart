import 'package:flutter/material.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';

class ColorContainer extends StatelessWidget {
  final color;
  final onTap;
  final isSelected;

  const ColorContainer(
      {Key? key,
      required this.color,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin:  EdgeInsets.symmetric(vertical : isSelected ? 2 : 5, horizontal: 2),
        width: 100,
        height: isSelected ? 30 : 20,
        decoration: BoxDecoration(
            color: color,
            border:
                isSelected ? Border.all(width: 2, color: Colors.blue) : null,
            borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
