import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_controller.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:shortid/shortid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../widgets/custom_date_button.dart';
import '../widgets/my_date_picker.dart';

class InvoiceInformationScreen extends ConsumerStatefulWidget {
  const InvoiceInformationScreen({super.key});

  @override
  ConsumerState<InvoiceInformationScreen> createState() =>
      _InvoiceInformationScreenState();
}

class _InvoiceInformationScreenState
    extends ConsumerState<InvoiceInformationScreen> {
  TextEditingController postCodeController = TextEditingController();
  TextEditingController termsAndCondController = TextEditingController();
  final DateRangePickerController _issueDateController =
      DateRangePickerController();
  final DateRangePickerController _dueDateController =
      DateRangePickerController();

  InVoiceModel? invoice;
  DateTime? issueDate;
  DateTime? dueDate;

  // String? termsAndCond;
  String? selectedInvoice;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      invoice = ref.read(invoiceDataProvider.notifier).invoiceModel;
     // invoice = null;
      if (invoice != null) {
        selectedInvoice = invoice!.invoiceNo;
        issueDate = invoice!.issueDate;
        dueDate = invoice!.dueDate;
        termsAndCondController.text = invoice!.termsAndCond;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    postCodeController.dispose();
    _issueDateController.dispose();
    _dueDateController.dispose();
    termsAndCondController.dispose();
    issueDate = null;
    dueDate = null;
    // termsAndCond = null;
    selectedInvoice = null;
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
          'Invoice information',
          style: getLibreBaskervilleExtraBoldStyle(
            color: context.titleColor,
            fontSize: MyFonts.size16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invoice information',
                style: getBoldStyle(color: Colors.black, fontSize: 18),
              ),
              // CommonDropDown(
              //     value: selectedInvoice,
              //     hintText: '',
              //     label: 'Invoice number',
              //     valueItems: const ['1234', '4567'],
              //     onChanged: (value) {
              //       selectedInvoice = value;
              //       setState(() {});
              //     }),
              CustomDateButton(
                  value: issueDate,
                  label: 'Invoice date',
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return MyDatePicker(
                            dateController: _issueDateController,
                            onDone: () {
                              issueDate = _issueDateController.selectedDate;
                              setState(() {});
                              Navigator.of(context).pop();
                            },
                          );
                        });
                  }),
              CustomDateButton(
                  value: dueDate,
                  label: 'Due date',
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return MyDatePicker(
                            dateController: _dueDateController,
                            onDone: () {
                              dueDate = _dueDateController.selectedDate;
                              setState(() {});
                              Navigator.of(context).pop();
                            },
                          );
                        });
                  }),
              CustomTextField(
                  controller: termsAndCondController,
                  hintText: '',
                  maxLines: 8,
                  verticalPadding: 8.h,
                  label: 'Due Terms & condition'),
              // CommonDropDown(
              //     value: termsAndCond,
              //     hintText: '',
              //     label: 'Due terms and condition',
              //     valueItems: const [
              //       'terms and condition 1',
              //       'terms and condition 2'
              //     ],
              //     onChanged: (value) {
              //       termsAndCond = value;
              //       setState(() {});
              //     }),
              // CustomTextField(
              //     controller: postCodeController,
              //     hintText: '',
              //     label: 'Post code'),
              Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                return CustomButton(
                    onPressed: () {
                      if (issueDate == null) {
                        showSnackBar(context, 'Select invoice date');
                        return;
                      }
                      if (dueDate == null) {
                        showSnackBar(context, 'Select due date');
                        return;
                      }
                      ref.read(invoiceDataProvider.notifier).setInVoiceInFoData(
                          invoice: invoice != null ?
                          invoice!.copyWith(
                              issueDate: issueDate!,
                              dueDate: dueDate!,
                              termsAndCond: termsAndCondController.text ?? ''
                          ) : InVoiceModel(
                              invoiceNo: shortid.generate(),
                              issueDate: issueDate!,
                              dueDate: dueDate!,
                              termsAndCond: termsAndCondController.text ?? ''));
                      showSnackBar(context, 'info is set.');
                      Navigator.of(context).pop();
                      // } else {
                      //   showSnackBar(context, 'Fill all fields');
                      // }
                    },
                    buttonText: "Save");
              })
            ],
          ),
        ),
      ),
    );
  }
}
