import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/tax_setting/controller/tax_controller.dart';
import 'package:invoice_producer/models/tax_model/tac_stat_model.dart';
import 'package:invoice_producer/routes/route_manager.dart';

import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../utils/loading.dart';
import '../../app_setting/widget/switch_button.dart';
import '../widgets/tax_container.dart';

class TaxSettings extends ConsumerStatefulWidget {
  const TaxSettings({Key? key}) : super(key: key);

  @override
  ConsumerState<TaxSettings> createState() => _TexSettingsState();
}

class _TexSettingsState extends ConsumerState<TaxSettings> {
  bool enableTax = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        floatingActionButton: CustomFloatingActionButton(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.createTaxScreen);
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
            'Tax settings',
            style: getLibreBaskervilleBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.all(AppConstants.padding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          final taxCtr = ref.watch(taxControllerProvider.notifier);
                          return ref.watch(getTaxStatus(context)).when(
                              data: (model){
                                return SwitchButton(
                                    onTap: () {
                                      setState(() {
                                        enableTax = !enableTax;
                                      });
                                      taxCtr.enableDisableTax(context: context, taxModel: TaxStatModel(
                                          isEnabled: enableTax
                                      ));
                                    },
                                    title: 'Enable Tax',
                                    value: model.isEnabled);
                              },
                              error: (e, st){
                                debugPrintStack(stackTrace: st);
                                debugPrint(e.toString());
                                return SwitchButton(
                                    onTap: () {
                                      setState(() {
                                        enableTax = !enableTax;
                                      });
                                      taxCtr.enableDisableTax(context: context, taxModel: TaxStatModel(
                                          isEnabled: enableTax
                                      ));
                                    },
                                    title: 'Enable Tax',
                                    value: enableTax);
                              },
                              loading: (){
                                return const SizedBox();
                              }
                          );
                        },
                      ),
                      Text("Tax list",
                          style: getSemiBoldStyle(
                              color: context.titleColor, fontSize: MyFonts.size18)),
                      padding12,
                      ref.watch(getAllTaxesProvider).when(
                        data: (taxList) {
                          return taxList.isEmpty
                              ? const Center(child: Text('No Tax found'))
                              : ListView.builder(
                            shrinkWrap: true,
                            itemCount: taxList.length,
                            itemBuilder: (context,index){
                              final tax = taxList[index];
                              return TaxContainer(
                                title:tax.name,
                                subTitle: tax.percentage.toString(),
                                onSelect: (value){
                                  if (value == 'edit') {
                                    Navigator.pushNamed(
                                        context, AppRoutes.createTaxScreen,
                                        arguments: {'tax': tax,});
                                  } else {
                                    ref.read(taxControllerProvider.notifier)
                                        .deleteTax(
                                        context : context, taxId : tax.taxId);
                                  }
                                },
                              );
                            },
                            // children: [
                            //   TaxContainer(title: 'New Text',subTitle: '%10',),
                            //   TaxContainer(title: 'Old Text',subTitle: '%20',),
                            // ],
                          );
                        },
                        error: (error, st) {
                          debugPrintStack(stackTrace: st);
                          debugPrint(error.toString());
                          return ErrorWidget(error);
                        },
                        loading: () {
                          return LoadingWidget(size: 24.r, color: context.greenColor,);
                        },
                      ),
                      // ListView(
                      //   shrinkWrap: true,
                      //   children: [
                      //     TaxContainer(title: 'New Text',subTitle: '%10',),
                      //     TaxContainer(title: 'Old Text',subTitle: '%20',),
                      //   ],
                      // )
                    ]))));
  }
}
