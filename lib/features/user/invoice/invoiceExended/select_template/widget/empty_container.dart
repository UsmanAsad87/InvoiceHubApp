import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/utils/loading.dart';

class EmptyContainer extends StatelessWidget {
  final int? color;
  const EmptyContainer({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color:  Color(color ?? 0xFFF9DCB1),
      margin: EdgeInsets.symmetric(vertical: 20.r, horizontal: 10.r),
      child: LoadingWidget(color : context.greenColor, size: 40.r,),
    );
  }
}
