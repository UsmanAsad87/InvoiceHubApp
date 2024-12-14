import '../common_imports/common_libs.dart';

class CommonGradientLine extends StatelessWidget {
  const CommonGradientLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('commonGradientLine'),
      height: 1,
      width: 327.sw,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          context.whiteColor.withOpacity(0.0),
          context.whiteColor,
          context.whiteColor.withOpacity(0.0),
        ],
        stops: const [0, 0.5, 1],
      )),
    );
  }
}
