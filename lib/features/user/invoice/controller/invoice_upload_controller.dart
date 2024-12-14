import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_producer/commons/common_functions/upload_image_to_firebase.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/core/constants/firebase_constants.dart';
import 'package:invoice_producer/core/enums/date_filter_type.dart';
import 'package:invoice_producer/core/enums/invoice_status_enum.dart';
import 'package:invoice_producer/features/user/invoice/api/invoice_api_provider.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../routes/route_manager.dart';
import '../../../auth/data/auth_apis/auth_apis.dart';
import '../../../auth/data/auth_apis/database_apis.dart';

final invoiceUploadControllerProvider =
StateNotifierProvider<InvoiceUploadController, bool>((ref) {
  return InvoiceUploadController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(invoiceDataBaseApiProvider),
    userdatabaseApis: ref.watch(databaseApisProvider),
  );
});

final getAllInvoicesProvider =
StreamProvider((ref) {
  final invoiceCtr = ref.watch(invoiceUploadControllerProvider.notifier);
  return invoiceCtr.getAllInVoices(searchQuery: '');
});


final getAllSearchInvoicesProvider =
StreamProvider.family((ref, String searchQuery) {
  final invoiceCtr = ref.watch(invoiceUploadControllerProvider.notifier);
  return invoiceCtr.getAllInVoices(searchQuery: searchQuery);
});


final getDraftInvoicesProvider =
StreamProvider.family((ref, String searchQuery) {
  final invoiceCtr = ref.watch(invoiceUploadControllerProvider.notifier);
  return invoiceCtr.getAllDraftInVoices(searchQuery: searchQuery);
});


final getCustomerInvoices =
StreamProvider.family((ref, String customerId) {
  final invoiceCtr = ref.watch(invoiceUploadControllerProvider.notifier);
  return invoiceCtr.getCustomerInvoices(customerId: customerId,);
});

final getInvoicesCountProvider =
StreamProvider.family((ref, BuildContext context) {
  final invoiceCtr = ref.watch(invoiceUploadControllerProvider.notifier);
  return invoiceCtr.getAllInVoicesCount(context: context);
});

final getSpecificInvoicesCountProvider =
FutureProvider.family((ref, DateFilterType filterType) {
  final invoiceCtr = ref.watch(invoiceUploadControllerProvider.notifier);
  return invoiceCtr.getInvoicesCount(filterType: filterType);
});

final getPaidInvoicesCountProvider =
FutureProvider.family((ref, DateFilterType filterType) {
  final invoiceCtr = ref.watch(invoiceUploadControllerProvider.notifier);
  return invoiceCtr.getPaidInvoicesCount(filterType: filterType);
});

class InvoiceUploadController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final InvoiceDatabaseApi _databaseApis;

  InvoiceUploadController({
    required AuthApis authApis,
    required InvoiceDatabaseApi databaseApis,
    required DatabaseApis userdatabaseApis,
  })
      : _authApis = authApis,
        _databaseApis = databaseApis,
        super(false);

  Future<void> addInvoice({required BuildContext context,
    required InVoiceModel invoice,
    List<XFile>? workSamples,
    File? logo}) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    String? logoURL;
    List<String>? workSampleURLs;
    if (logo != null) {
      logoURL = await uploadImage(
        img: logo,
        storageFolderName: userId!.uid,
        subFolderName: FirebaseConstants.invoiceCollection,
      );
    } else {
      logoURL = invoice.company!.logo;
    }
    if (workSamples != null) {
      workSampleURLs = await uploadImages(workSamples,
          storageFolderName: userId!.uid,
          subFolderName: FirebaseConstants.invoiceCollection);
    }
    InVoiceModel updateInvoice = invoice.copyWith(
      image: logoURL,
      workSamples: workSampleURLs,
    );
    final result = await _databaseApis.addInvoice(
        userId: userId!.uid, invoice: updateInvoice);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      if (invoice.isDraft!) {
        Navigator.of(context).pop();
        showSnackBar(context, 'Invoice draft successfully');
        return;
      }
      showSnackBar(context, 'Invoice added successfully');
      Navigator.pushNamed(context, AppRoutes.selectTemplateScreen,
          arguments: {'invoice': updateInvoice});
    });
  }


  Future<void> updateInvoice({required BuildContext context,
    required InVoiceModel inVoiceModel,
    File? logo}) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    String? logoURL;
    InVoiceModel? updatedInvoice;
    if (logo != null) {
      logoURL = await uploadImage(
        img: logo,
        storageFolderName: userId!.uid,
        subFolderName: FirebaseConstants.invoiceCollection,
      );
      updatedInvoice = inVoiceModel.copyWith(image: logoURL);
    }
    final result = await _databaseApis.updateInvoice(
        userId: userId!.uid, invoice: updatedInvoice ?? inVoiceModel);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      if (inVoiceModel.invoiceStatusEnum?.name == InvoiceStatusEnum.paid.name) {
        showSnackBar(context, 'Invoice Marked as Paid');
        Navigator.pop(context);
      } else {
        Navigator.pushNamed(context, AppRoutes.selectTemplateScreen,
            arguments: {'invoice': updatedInvoice ?? inVoiceModel});
        showSnackBar(context, 'Invoice update successfully');
      }
    });
  }

  Stream<List<InVoiceModel>> getAllInVoices({String? searchQuery}) {
    final user = _authApis.getCurrentUser();
    Stream<List<InVoiceModel>> invoices = _databaseApis.getAllInVoices(
      userId: user!.uid, searchQuery: searchQuery ?? '',);
    return invoices;
  }

  Stream<List<InVoiceModel>> getAllDraftInVoices(
      {required String searchQuery}) {
    final user = _authApis.getCurrentUser();
    Stream<List<InVoiceModel>> invoices = _databaseApis.getAllDraftInVoices(
        userId: user!.uid, searchQuery: searchQuery);
    return
    invoices;
  }

  Stream<List<InVoiceModel>> getCustomerInvoices({
    required String customerId,
  }) {
    final user = _authApis.getCurrentUser();
    Stream<List<InVoiceModel>> invoices =
    _databaseApis.getInVoicesOfCustomerIdStream(
        userId: user!.uid,
        customerId: customerId
    );
    return invoices;
  }

  /// get specific customer invoices
  Future<List<InVoiceModel>> getInvoicesOfCustomerId({
    required BuildContext context,
    required String customerId,
  }) async {
    try {
      final user = _authApis.getCurrentUser();
      List<InVoiceModel> invoices = await _databaseApis.getInVoicesOfCustomerId(
          userId: user!.uid, customerId: customerId);

      return invoices;
    } catch (error) {
      showSnackBar(context, 'Error getting report');
      return [];
    }
  }


  Stream<int> getAllInVoicesCount({
    required BuildContext context,
  }) {
    try {
      final user = _authApis.getCurrentUser();
      Stream<int> companies = _databaseApis.getAllInVoicesCount(
        userId: user!.uid,
      );
      return companies;
    } catch (error) {
      showSnackBar(context, 'Error getting invoices: $error');
      return Stream.value(0);
    }
  }

  Future<int?> getInvoicesCount({
    required DateFilterType filterType,
  }) async {
    final user = _authApis.getCurrentUser();
    final count = await _databaseApis.getInvoicesCount(
      userId: user!.uid,
      filterType: filterType,
    );
    return count.fold(
          (l) {
        return 0;
      },
          (r) {
        return r;
      },
    );
  }

  Future<int?> getPaidInvoicesCount({
    required DateFilterType filterType,
  }) async {
    final user = _authApis.getCurrentUser();
    final count = await _databaseApis.getPaidInvoicesCount(
      userId: user!.uid,
      filterType: filterType,
    );
    return count.fold(
          (l) {
        return 0;
      },
          (r) {
        return r;
      },
    );
  }

  Future<List<InVoiceModel>> getPaidInvoices({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final user = _authApis.getCurrentUser();
      if (user == null) {
        return [];
      }

      final invoicesSnapshot = await _databaseApis.getInvoicesWithinDateRange(
        userId: user.uid,
        startDate: startDate,
        endDate: endDate,
      );

      final invoices = invoicesSnapshot.docs
          .map((doc) =>
          InVoiceModel.fromMap(doc.data() as Map<String, dynamic>))
          .where((invoice) =>
      invoice.isPaid == true) // Filter for paid invoices
          .toList();

      return invoices;
    } catch (e) {
      return [];
    }
  }

  Future<void> deleteInvoice({
    required BuildContext context,
    required String invoiceId
  }) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    final result = await _databaseApis.deleteInvoice(
        userId: userId!.uid, invoiceId: invoiceId);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      showSnackBar(context, 'Invoice deleted successfully');
      Navigator.of(context).pop();
    });
  }

  // Future<void> deleteAllUserInvoices() async {
  //   state = true;
  //   await _databaseApis.deleteAllUserInvoices();
  //   print('ffffffffffffffffff Fineshed');
  // }


}
