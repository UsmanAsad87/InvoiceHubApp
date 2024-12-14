import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  final Function()? onTap;
  final image;
  const CustomIconButton({Key? key,required this.image, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          image,
          color: Colors.black,
          scale: .9.sp,),
      ),
    );
  }
}
