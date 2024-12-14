import 'package:flutter/material.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_outline_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../../../utils/constants/app_constants.dart';

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyDatePicker(),
//     );
//   }
// }

class MyDatePicker extends StatefulWidget {
  final DateRangePickerController? dateController;
  final Function()? onDone;
  const MyDatePicker({super.key, this.dateController, this.onDone});
  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  late DateRangePickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.dateController ?? DateRangePickerController();
    _controller.displayDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: context.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      backgroundColor: Colors.white,
      child : Container(
        padding: EdgeInsets.all(AppConstants.padding),
        // width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_outlined,color: context.greenColor,),
                  onPressed: () {
                    setState(() {
                      _controller.backward!();
                    });
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      _getFormattedMonth(_controller.displayDate!),
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined,color: context.greenColor,),
                  onPressed: () {
                    setState(() {
                      _controller.forward!();
                    });
                  },
                ),
              ],
            ),

            // Middle Section: Syncfusion Date Picker
            SfDateRangePicker(
              controller: _controller,
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.single,
              selectionColor: context.greenColor,
              showNavigationArrow: false,
              monthCellStyle: const DateRangePickerMonthCellStyle(
                textStyle: TextStyle(fontSize: 10.0),
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle: getRegularStyle(color: context.greenColor))),
            ),
            // Bottom Section: Two Outlined Buttons and One Elevated Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomOutlineButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, buttonText: 'Cancel'),
                )),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                      onPressed: widget.onDone ?? (){
                        DateTime selectedDate = _controller.selectedDate ?? _controller.displayDate!;
                      },
                      buttonText: 'Done'),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedMonth(DateTime date) {
    return '${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }
}
