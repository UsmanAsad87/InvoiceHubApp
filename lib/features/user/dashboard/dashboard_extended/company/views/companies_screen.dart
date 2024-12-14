import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/company/controller/comany_controller.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';
import '../../../../../../commons/common_shimmers/list_item_shimmer.dart';
import '../../../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../../../models/company_models/company_model.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../utils/loading.dart';
import '../widget/company_card.dart';

class CompaniesScreen extends ConsumerStatefulWidget {
  const CompaniesScreen({super.key});

  @override
  ConsumerState<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends ConsumerState<CompaniesScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      floatingActionButton: CustomFloatingActionButton(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.createCompanyScreen);
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
          'Company',
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
              Text("Company List",
                  style: getSemiBoldStyle(
                      color: context.titleColor, fontSize: MyFonts.size16)),
              padding12,
              ref.watch(getAllCompaniesProvider(context)).when(
                data: (companiesList) {
                  return companiesList.isEmpty
                      ? const Center(child: Text('No company found'))
                      : ListView.builder(
                          itemCount: companiesList.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final company = companiesList[index];
                            return CompanyCard(
                              company: company,
                              onSelect: (value) {
                                if (value == 'edit') {
                                  Navigator.pushNamed(
                                      context, AppRoutes.createCompanyScreen,
                                      arguments: {'company': company});
                                } else {
                                  ref
                                      .read(companyControllerProvider.notifier)
                                      .deleteCompany(
                                          context : context, companyId : company.companyId);
                                }
                              },
                            );
                          });
                },
                error: (error, st) {
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return ErrorWidget(error);
                },
                loading: () {
                  return  ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, snapshot) {
                        return const ListItemShimmer();
                      }
                  );
                },
              ),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
