import 'package:flutter/material.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';

class TabButtonWidget extends StatelessWidget {
  final bool isSelected;
  final Function() onTap;
  final String buttonText;
  const TabButtonWidget({Key? key,required this.isSelected,required this.onTap,required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        focusColor: null,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 2, color : isSelected ? context.greenColor : context.titleColor.withOpacity(.6))),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                buttonText,
                style: getSemiBoldStyle(color: isSelected ? context.greenColor : context.titleColor.withOpacity(.6),fontSize: MyFonts.size15)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
