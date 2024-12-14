// import 'package:invoice_producer/commons/common_imports/common_libs.dart';
// import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
// import 'package:invoice_producer/routes/route_manager.dart';
// import 'package:invoice_producer/utils/constants/app_constants.dart';
// import 'package:invoice_producer/utils/constants/assets_manager.dart';
//
// class ResetSuccessDialog extends StatelessWidget {
//   const ResetSuccessDialog({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(30.r),
//       ),
//       backgroundColor: Colors.transparent,
//       child: Container(
//         padding: EdgeInsets.all(AppConstants.padding),
//         decoration: BoxDecoration(
//           color:
//           context.greenColorContainer.withOpacity(0.9),
//           borderRadius: BorderRadius.circular(30.r),
//           boxShadow: [
//             BoxShadow(
//               color: context.greenColor.withOpacity(0.1),
//               // spreadRadius: 12,
//               blurRadius: 8,
//               offset: const Offset(2, 2),
//             ),
//           ],
//
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Image.asset(AppAssets.dialogCloseIcon,
//                       width: 38.w, height: 38.h),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 12.h,
//             ),
//             Image.asset(AppAssets.greenCheckIcon, width: 86.w, height: 86.h),
//             SizedBox(
//               height: 32.h,
//             ),
//             Text(
//               'Password Has Been Successfully\n Updated',
//               textAlign: TextAlign.center,
//               style: getRegularStyle(
//                   color: context.greenColor,
//                   fontSize: MyFonts.size14),
//             ),
//             SizedBox(
//               height: 32.h,
//             ),
//             SizedBox(
//               width: 150.w,
//               child: CustomButton(
//                 onPressed: () {
//                   Navigator.pushNamedAndRemoveUntil(
//                       context, AppRoutes.signInScreen, (route) => false);
//                 },
//                 buttonText: 'Login Now',
//               ),
//             ),
//             SizedBox(
//               height: 38.h,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }