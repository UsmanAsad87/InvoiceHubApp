import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/support/controller/customer_controller.dart';
import 'package:invoice_producer/models/support_model/support_model.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../widgets/support_profile_image.dart';
import 'package:uuid/uuid.dart';

class SendSupportMessageScreen extends ConsumerStatefulWidget {
  const SendSupportMessageScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SendSupportMessageScreen> createState() =>
      _SendSupportMessageScreenState();
}

class _SendSupportMessageScreenState
    extends ConsumerState<SendSupportMessageScreen> {
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
        backgroundColor: context.scaffoldBackgroundColor,
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
            'Support',
            style: getLibreBaskervilleBoldStyle(
                color: context.titleColor,
                fontSize: MyFonts.size16),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              SupportProfileImage(
                imgUrl: AppAssets.supportIcon,
                name: 'Take necessary support from our expert team',
              ),
              Padding(
                padding: EdgeInsets.all(AppConstants.padding),
                child: Column(
                  children: [
                    CustomTextField(
                        controller: subjectController,
                        hintText: '',
                        label: 'Subject'),
                    CustomTextField(
                      controller: messageController,
                      hintText: '',
                      label: 'Message',
                      verticalPadding: 6.sp,
                      maxLines: 7,
                    ),
                    CustomButton(
                      onPressed: () async {
                        final supportModel = SupportModel(
                          id: const Uuid().v4(),
                          userId: '',
                          subject: subjectController.text.trim(),
                          message: messageController.text.trim(),
                          createdOn: DateTime.now(),
                        );
                        ref.read(supportControllerProvider.notifier).addSupport(
                            context: context, supportModel: supportModel);
                        await _sendEmail();
                      },
                      isLoading: ref.watch(supportControllerProvider),
                      buttonText: 'Send message',
                    ),
                  ],
                ),
              ),
            ])));
  }

  Future<void> _sendEmail() async {
    const String email = 'invoicehub.official@gmail.com';
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=${subjectController.text}&body=${messageController.text}',
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch $emailUri';
    }
  }
}
