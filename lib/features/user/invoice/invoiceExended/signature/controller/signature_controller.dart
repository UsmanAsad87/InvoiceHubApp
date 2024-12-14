import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:invoice_producer/features/user/invoice/invoiceExended/signature/api/signature_api_provider.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../commons/common_functions/upload_image_to_firebase.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../commons/common_widgets/show_toast.dart';
import '../../../../../../core/constants/firebase_constants.dart';
import '../../../../../../models/signature_model/signature_model.dart';
import '../../../../../auth/data/auth_apis/auth_apis.dart';

final signatureControllerProvider =
    StateNotifierProvider<SignatureController, bool>((ref) {
  return SignatureController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(SignatureDatabaseApiProvider),
  );
});

final getAllSignatureProvider =
    StreamProvider.family((ref, BuildContext context) {
  final customerCtr = ref.watch(signatureControllerProvider.notifier);
  return customerCtr.getAllSignature(context: context);
});

class SignatureController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final SignatureDatabaseApi _databaseApis;

  SignatureController({
    required AuthApis authApis,
    required SignatureDatabaseApi databaseApis,
  })  : _authApis = authApis,
        _databaseApis = databaseApis,
        super(false);

  Future<void> addSignature({
    required BuildContext context,
    required SignatureModel signatureModel,
    Uint8List? imageByes,
  }) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    File? signImage;
    if (imageByes != null) {
      final Directory appDir =
      await getApplicationCacheDirectory();
      final String appDirPath = appDir.path;
      final String filePath = '$appDirPath/signature.png';
      signImage = await File(filePath).writeAsBytes(imageByes);
    }

    String? image = await uploadImage(
        img: signImage ?? File(signatureModel.image),
        storageFolderName: userId!.uid,
        subFolderName: FirebaseConstants.signatureCollection);
    final updateSignature = signatureModel.copyWith(image: image);
    final result = await _databaseApis.addSignature(
        userId: userId.uid, signatureModel: updateSignature);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      showSnackBar(context, 'Signature added successfully');
      Navigator.of(context).pop();
    });
  }

  Stream<List<SignatureModel>> getAllSignature({
    required BuildContext context,
  }) {
    try {
      final user = _authApis.getCurrentUser();
      Stream<List<SignatureModel>> signatures =
          _databaseApis.getAllSignature(userId: user!.uid);
      return signatures;
    } catch (error) {
      showSnackBar(context, 'Error getting signatures: $error');
      return const Stream.empty();
      // Handle the error as needed
    }
  }

  Future<void> updateSignature(
      {required BuildContext context,
      required SignatureModel signatureModel,
      String? imagePath}) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    SignatureModel? updateSign;
    if (imagePath != null) {
      String? image = await uploadImage(
          img: File(imagePath!),
          storageFolderName: userId!.uid,
          subFolderName: FirebaseConstants.signatureCollection);
      updateSign = signatureModel.copyWith(image: image);
    }
    final result = await _databaseApis.updateSignature(
        userId: userId!.uid, signatureModel: updateSign ?? signatureModel);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'Signature update successfully');
      Navigator.of(context).pop();
    });
  }

  Future<void>? deleteSignature(
      {required BuildContext context, required String signatureId})  {
    try {
      final userId = _authApis.getCurrentUser();
      _databaseApis.deleteSignature(
          userId: userId!.uid, signatureId: signatureId);
      showSnackBar(context, 'Signature deleted successfully');
    } catch (e) {
      showSnackBar(context, 'something went wrong');
    }
    return null;
  }
}
