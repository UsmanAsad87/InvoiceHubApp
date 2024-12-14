import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_outline_button.dart';
import 'package:invoice_producer/features/user/invoice/widgets/socialmdedia_container.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../main_menu/controller/main_menu_controller.dart';
import '../controller/invoice_controller.dart';
import '../invoiceExended/select_template/controller/pdf_image_noti_ctr.dart';
import '../invoiceExended/select_template/controller/pdf_state.dart';


class CongratsScreen extends ConsumerStatefulWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CongratsScreen> createState() => _CongratsScreenState();
}

class _CongratsScreenState extends ConsumerState<CongratsScreen> {




  @override
  Widget build(BuildContext context) {
    final invoice = ref.read(invoiceDataProvider.notifier).invoiceModel;
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: SvgPicture.asset(
                      AppAssets.tickCircle,
                      width: 214.w,
                      height: 214.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Text(
                      'Congratulations!',
                      style: getBoldStyle(
                          color: context.titleColor, fontSize: MyFonts.size24),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Text(
                      'You\'ve successfully sent your invoice to your customer',
                      style: getRegularStyle(
                          color: context.titleColor.withOpacity(.5),
                          fontSize: MyFonts.size18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  padding30,
                  Container(
                    padding: EdgeInsets.all(AppConstants.padding),
                    margin: EdgeInsets.all(AppConstants.padding),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: context.whiteColor,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            width: .5, color: context.containerColor)),
                    child: Column(
                      children: [
                        Text(
                          'Share with social media',
                          style: getBoldStyle(
                              color: context.titleColor,
                              fontSize: MyFonts.size16),
                          textAlign: TextAlign.center,
                        ),
                        padding30,
                        Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            final pdgImgCtr = ref.watch(pdfImgNotiController);
                            return InkWell(
                              onTap: () async {
                                // handleExistingPdf(ref.watch(pdfProvider).generatedFile!);
                                await Share.shareXFiles(
                                    pdgImgCtr.image != null?
                                    [
                                    XFile(ref.watch(pdfProvider).generatedFile!.path),
                                      XFile(pdgImgCtr.image!.path),
                                    ]: [
                                    XFile(ref.watch(pdfProvider).generatedFile!.path),
                                  ],
                                  text: '${invoice!.paymentAccount?.accountType}'
                                      ' \n ${invoice.paymentAccount?.accountNo}',
                                );
                              },
                              splashColor: Colors.transparent,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SocialmdediaContainer(
                                      imagePath: AppAssets.linkedInImage,
                                      color: MyColors.linkedInColor),
                                  SocialmdediaContainer(
                                      imagePath: AppAssets.instagramImage,
                                      color: MyColors.instagramColor),
                                  SocialmdediaContainer(
                                      imagePath: AppAssets.facebookImage,
                                      color: MyColors.facebookContainerColor),
                                  SocialmdediaContainer(
                                      imagePath: AppAssets.twitterImage,
                                      color: MyColors.twitterContainerColor)
                                ],
                              ),);
                          },
                        ),
                        padding20
                      ],
                    ),
                  ),
                  padding8,
                  Container(
                    padding: EdgeInsets.all(AppConstants.padding),
                    margin: EdgeInsets.all(AppConstants.padding),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: context.whiteColor,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            width: .5, color: context.containerColor)),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.link,
                          color: context.titleColor,
                        ),
                        padding8,
                        Expanded(
                          child: Text(
                            'https://www.Invoiceproducer.com/company',
                            style: getRegularStyle(color: context.titleColor),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  padding30,
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: CustomOutlineButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.scanQrcodeScreen);
                            },
                            buttonText: 'Scan QR code'),
                      )),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Consumer(builder: (context, ref, child) {
                                final pdgImgCtr = ref.watch(pdfImgNotiController);
                                return CustomButton(
                                    onPressed: () {
                                      ref.read(mainMenuProvider).setIndex(0);
                                      pdgImgCtr.setPdfImage(null);
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes.mainMenuScreen,
                                          (route) => false);
                                    },
                                    buttonText: 'Back to Home');
                              })))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
