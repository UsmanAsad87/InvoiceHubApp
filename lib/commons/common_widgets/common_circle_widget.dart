import '../common_imports/common_libs.dart';

class CommonCircleWidget extends StatelessWidget {
  final String circlePath;

  const CommonCircleWidget({Key? key, required this.circlePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      circlePath,
      width: 250.w,
      height: 250.h,
    );
  }
}

class CommonCircleWidget200 extends StatelessWidget {
  final String circlePath;

  const CommonCircleWidget200({Key? key, required this.circlePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      circlePath,
      width: 200.w,
      height: 200.h,
    );
  }
}
