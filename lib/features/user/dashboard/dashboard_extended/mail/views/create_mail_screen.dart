import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/mail/widgets/profile_image.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/mail/widgets/attachment_widget.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../commons/common_widgets/common_dropdown.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/assets_manager.dart';

class CreateMailScreen extends ConsumerStatefulWidget {
  const CreateMailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateMailScreen> createState() => _CreateMailScreenState();
}

class _CreateMailScreenState extends ConsumerState<CreateMailScreen> {
  List<String> customers = [
    'Eleanor Pena',
    'Cameron Williamson',
    'Marvin McKinney'
  ];

  List<String> invoiceNumbers = [
    '1234',
    '4356',
    '5432',
  ];
  String? selectedInvoice;
  String? selectedCustomer;
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: context.scaffoldBackgroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(AppAssets.backArrowIcon,
                width: 20.w, height: 20.h, color: context.titleColor),
          ),
          title: Text(
            'Create mail',
            style: getLibreBaskervilleExtraBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              const ProfileImage(
                imgUrl: personImg,
                name: 'ELeanor Pena',
              ),
              Padding(
                padding: EdgeInsets.all(AppConstants.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonDropDown(
                      valueItems: customers,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCustomer = newValue;
                        });
                      },
                      value: selectedCustomer,
                      hintText: '',
                      label: 'Message to',
                    ),
                    CustomTextField(
                        controller: subjectController,
                        hintText: '',
                        label: 'Subject'),
                    CommonDropDown(
                      valueItems: invoiceNumbers,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedInvoice = newValue;
                        });
                      },
                      value: selectedInvoice,
                      hintText: '',
                      label: 'Invoice Number',
                    ),
                    CustomTextField(
                      controller: messageController,
                      hintText: '',
                      label: 'message',
                      verticalPadding: 6.sp,
                      maxLines: 7,
                    ),
                    AttachmentWidget(onTap: () {}),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomButton(onPressed: () {}, buttonText: 'Send message')
                  ],
                ),
              ),
            ])));
  }
}
