import 'package:flutter/material.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';

class InformationCard extends StatelessWidget {
  final title;
  final subTitle;
  const InformationCard({Key? key,required this.title, required  this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              getSemiBoldStyle(fontSize: MyFonts.size14, color: context.titleColor),
        ),
        Text(
          subTitle,
          style: getRegularStyle(fontSize: MyFonts.size14, color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(
            thickness: 1,
            color: context.titleColor.withOpacity(.3),
          ),
        )
      ],
    );
  }
}
