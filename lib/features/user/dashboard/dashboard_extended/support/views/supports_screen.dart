import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/support/controller/customer_controller.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/support/widgets/support_message_card.dart';
import 'package:invoice_producer/utils/loading.dart';

import '../../../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../../../routes/route_manager.dart';
import '../../../../../../utils/constants/assets_manager.dart';

class SupportScreen extends ConsumerStatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends ConsumerState<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      floatingActionButton: CustomFloatingActionButton(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.sendSupportMessageScreen);
        },
      ),
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leading: Consumer(builder: (context, ref, child) {
          return IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(AppAssets.backArrowIcon,
                width: 20.w, height: 20.h, color: context.titleColor),
          );
        }),
        title: Text(
          'Supports',
          style: getLibreBaskervilleBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: ref.watch(getAllSupportMailsProvider).when(
            data: (mails) {
              return mails.isEmpty
                  ? Text(
                      'No Mails Yet!',
                      style: getMediumStyle(color: context.bodyTextColor),
                    )
                  : ListView.builder(
                      itemCount: mails.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SupportMessageCard(
                          onTap: () {
                            // Navigator.pushNamed(context, AppRoutes.conversationScreen);
                          },
                          support: mails[index],
                        );
                      });
            },
            error: (e, s) => const SizedBox(),
            loading: () => const LoadingWidget(),
          ),
    );
  }
}
