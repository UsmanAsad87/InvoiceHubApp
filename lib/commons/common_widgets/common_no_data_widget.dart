import 'package:invoice_producer/commons/common_imports/common_libs.dart';

class NoDataWidget extends StatelessWidget {
  final String textToShow;

  const NoDataWidget({Key? key, required this.textToShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(textToShow,
              style: getMediumStyle(
                  fontSize: MyFonts.size16, color: context.whiteColor)),
        ),
      ],
    );
  }
}
