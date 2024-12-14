import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:fluttertoast/fluttertoast.dart';

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: context.greenColor,
    content: Text(
      content,
      style: getRegularStyle(fontSize: 12.spMin, color: context.whiteColor),
    ),
  ));
}

void showToast(
    {required String msg,
    Color? textColor,
    Color? backgroundColor,
    bool long = false}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: long ? Toast.LENGTH_LONG : Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor ?? Colors.white,
    textColor: textColor ?? Colors.black,
    fontSize: 12.spMin,
  );
}
