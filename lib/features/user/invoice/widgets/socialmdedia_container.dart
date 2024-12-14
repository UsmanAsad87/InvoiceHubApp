
import '../../../../commons/common_imports/common_libs.dart';

class SocialmdediaContainer extends StatelessWidget {
  final imagePath;
  final color;
  const SocialmdediaContainer({Key? key,required this.imagePath,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50.w,
        height: 50.h,
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: color,
        ),
        child : Image.asset(imagePath)
    );
  }
}
