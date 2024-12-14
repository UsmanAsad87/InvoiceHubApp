// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../commons/common_imports/common_libs.dart';
// import '../../../../utils/loading.dart';
//
//
// Widget getCount({
//   required BuildContext context,
//   required WidgetRef ref,
//   required StreamProviderFamily provider
// }) => (ref
//     .watch(provider(context))
//     .when(
//     data: (count) => Text(
//       count.toString(),
//       style: getSemiBoldStyle(
//         fontSize: MyFonts.size16,
//         color: context.titleColor,
//       ),
//     ),
//     error: (error, st) => Text(
//       '#',
//       style: getBoldStyle(
//           color: context.whiteColor,
//           fontSize: MyFonts.size16),
//     ),
//     loading: () => LoadingWidget(
//         size: 12.r, color: context.whiteColor)));
//
//
//
// int getCountValue(ref, provider, context) {
//   try {
//     return ref.watch(provider(context)).data?.value?.toInt() ?? 1;
//   } catch (error, stackTrace) {
//     return 1;
//   }
// }
