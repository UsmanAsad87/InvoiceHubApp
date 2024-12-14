import 'package:intl/intl.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';




Widget spacer({double height = 16}) {
  return SizedBox(
    height: height,
  );
}

DateTime getDateTimeFromUnix(int dt) =>
    DateTime.fromMillisecondsSinceEpoch(dt * 1000);

String getTimeInHour(int dt) {
  final curDt = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  final hour = DateFormat('hh a').format(curDt);
  return hour;
}

String getTimeInHHMM(int dt) {
  final curDt = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  final hour = DateFormat('hh:mm a').format(curDt);
  return hour;
}

String getDayFromEpoch(int dt) {
  final curDt = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  final day = DateFormat('EEEE').format(curDt);
  return day;
}

String getDateMonthYear(DateTime dateTime) {
  var result  = DateFormat('MM/dd/yyyy').format(dateTime);
  return result;
}



class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.greenColor,
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key, this.message = 'Something went wrong !'})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: getMediumStyle(fontSize: 12.spMin,color:context.greenColor),
      ),
    );
  }
}

class NoRecordFound extends StatelessWidget {
  const NoRecordFound({Key? key, this.message = 'No Records'})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style:  getMediumStyle(fontSize: 12.spMin, color: context.greenColor),
      ),
    );
  }
}
