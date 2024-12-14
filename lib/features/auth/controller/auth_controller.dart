import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/core/enums/account_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/core/enums/signup_method_enum.dart';
import 'package:invoice_producer/features/auth/data/auth_apis/auth_apis.dart';
import 'package:invoice_producer/features/auth/data/auth_apis/database_apis.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../../../commons/common_functions/search_tags_handler.dart';
import '../../../commons/common_functions/upload_image_to_firebase.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../models/auth_models/user_model.dart';
import '../../user/main_menu/controller/main_menu_controller.dart';
import '../../user/userController.dart';
import 'auth_notifier_controller.dart';

//
final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(databaseApisProvider),
  );
});

//
final userStateStreamProvider = StreamProvider((ref) {
  final authProvider = ref.watch(authControllerProvider.notifier);
  return authProvider.getSigninStatusOfUser();
});

// final currentUserAuthProvider = FutureProvider((ref) {
//   final authCtr = ref.watch(authControllerProvider.notifier);
//   return authCtr.currentUser();
// });
// final currentUserModelData = FutureProvider((ref) {
//   final authCtr = ref.watch(authControllerProvider.notifier);
//   return authCtr.getCurrentUserInfo();
// });
//
// final fetchUserByIdProvider = StreamProvider.family((ref, String uid) {
//   final profileController = ref.watch(authControllerProvider.notifier);
//   return profileController.getUserInfoByUid(uid);
// });
//
//
//
final currentAuthUserinfoStreamProvider =
    StreamProvider.family((ref, String uid) {
  final profileController = ref.watch(authControllerProvider.notifier);
  return profileController.getCurrentUserInfoStream(uid: uid);
});

// final currUserAuthProvider = Provider((ref) {
//   final authCtr = ref.watch(authControllerProvider.notifier);
//   return authCtr.currUser();
// });

class AuthController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final DatabaseApis _databaseApis;

  AuthController(
      {required AuthApis authApis, required DatabaseApis databaseApis})
      : _authApis = authApis,
        _databaseApis = databaseApis,
        super(false);

//
//   Future<User?> currentUser() async {
//     return _authApis.getCurrentUser();
//   }
//
  Future<void> registerWithEmailAndPassword({
    required String fName,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.registerWithEmailAndPass(
        email: email, password: password);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      final searchTags = userSearchTagsHandler(
        email: email,
        fName: fName,
      );

      UserModel userModel = UserModel(
          uid: r.uid,
          fullName: fName,
          email: email,
          signUpMethod: SignUpMethodEnum.email,
          searchTags: searchTags,
          subscriptionId: '1',
          subscriptionAdded: DateTime.now(),
          subscriptionApproved: false,
          subscriptionIsValid: false,
          subscriptionName: 'Free plan',
          subscriptionExpire: DateTime.now().add(const Duration(days: 30)));

      final result2 = await _databaseApis.saveUserInfo(userModel: userModel);

      result2.fold((l) {
        state = false;
        debugPrintStack(stackTrace: l.stackTrace);
        debugPrint(l.message);
        showToast(msg: l.message);
      }, (r) async {
        state = false;
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.createCompanyScreen, (route) => false,
            arguments: {'isSkip': true});
        showToast(msg: 'Account Created Successfully!');
      });
    });
  }

  // bool hasLastName(String fullName) {
  //   int num = fullName.split(' ').length;
  //   return num > 1 ? true : false;
  // }

  // Update User Information
  Future<void> updateCurrentUserInfo({
    required BuildContext context,
    required WidgetRef ref,
    required UserModel userModel,
    String? newImagePath,
    String? oldImage,
  }) async {
    state = true;
    String? image = newImagePath != null
        ? await uploadXImage(XFile(newImagePath),
            storageFolderName: userModel.uid,
            subFolderName: FirebaseConstants.userCollection)
        : oldImage;

    UserModel model = userModel.copyWith(profileImage: image);

    final result = await _authApis.updateCurrentUserInfo(
        name: userModel.fullName, email: userModel.email, image: image!);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      final result2 =
          await _databaseApis.updateFirestoreCurrentUserInfo(userModel: model);
      result2.fold((l) {
        state = false;
        showSnackBar(context, l.message);
      }, (r) {
        state = false;
        UserController().refreshUserData(ref);
        showSnackBar(context, 'Profile Updated Successfully');
        Navigator.of(context).pop();
      });
    });
  }

  // refreshUserData(WidgetRef ref) async {
  //   final authCtr = ref.read(authControllerProvider.notifier);
  //   UserModel userModel = await authCtr.getCurrentUserInfo();
  //   final authNotifierProvider = ref.read(authNotifierCtr.notifier);
  //   authNotifierProvider.setUserModelData(userModel);
  // }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required bool rememberMe,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.signInWithEmailAndPass(
      email: email,
      password: password,
    );

    result.fold(
      (l) {
        state = false;
        showSnackBar(context, l.message);
      },
      (r) async {
        UserModel userModel = await getCurrentUserInfo();
        UserModel updatedUserModel = userModel.copyWith(rememberMe: rememberMe);
        final result2 = await _databaseApis.updateFirestoreCurrentUserInfo(
            userModel: updatedUserModel);
        result2.fold((l) {
          state = false;
          showSnackBar(context, l.message);
        }, (r) {
          state = false;
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.mainMenuScreen, (route) => false);
        });
      },
    );
  }

  //google sign in
  Future<void> signInWithGoogle({
    required BuildContext context,
        required WidgetRef ref}) async {
    try {
      state = true;

      final GoogleSignInAccount? googleUser =
      Theme.of(context).platform == TargetPlatform.iOS
          ? await GoogleSignIn(
        clientId:
        "1096174460927-ohheg08msvcqev4juoeo21fpcjg8bv79.apps.googleusercontent.com",
        scopes: ['email', 'profile'],
        hostedDomain: "",
      ).signIn()
          : await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // if (!isValidEmailFormat(googleUser!.email)) {
      //   showToast(msg: "Email format didn't match", long: true);
      //   state = false;
      //   return;
      // }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          // final name = userCredential.additionalUserInfo!.profile!['name'];
            final searchTags = userSearchTagsHandler(
              email: userCredential.additionalUserInfo!.profile!['email'],
              fName: userCredential.additionalUserInfo!.profile!['name'],
            );
          UserModel userModel = UserModel(
            uid: userCredential.user!.uid,
            fullName: userCredential.additionalUserInfo!.profile!['name'],
            email: userCredential.additionalUserInfo!.profile!['email'],
            profileImage:
            userCredential.additionalUserInfo!.profile!['picture'],
            fcmToken: '',
            searchTags: searchTags,
            signUpMethod: SignUpMethodEnum.google,
          );
          final result2 =
          await _databaseApis.saveUserInfo(userModel: userModel);
          result2.fold((l) {
            state = false;
            debugPrintStack(stackTrace: l.stackTrace);
            debugPrint(l.message);
            showToast(msg: l.message);
          }, (r) async {
            state = false;
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.mainMenuScreen, (route) => false);
          });
        } else {
          // setUserState(true);
          state = false;
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.mainMenuScreen, (route) => false);
          ref.read(mainMenuProvider).setIndex(0);
          return;
        }
      }
      state = false;
    } on FirebaseAuthException catch (e, st) {
      debugPrintStack(stackTrace: st);
      debugPrint(e.toString());
      state = false;
      if (e.toString() == 'Null check operator used on a null value') {
        return;
      }
      showSnackBar(context, e.message ??'');
      print('ffffffffffffff ${e.toString()}');
    } catch (e, st) {
      debugPrintStack(stackTrace: st);
      debugPrint(e.toString());
      state = false;
      if (e.toString() == 'Null check operator used on a null value') {
        return;
      }
      showSnackBar(context, e.toString());
      print('ffffffffffffff ${e.toString()}');
    }
  }


  Stream<UserModel> getCurrentUserInfoStream({required String uid}) {
    return _databaseApis.getCurrentUserStream(uid: uid).map((items) {
      UserModel userModel = UserModel.fromMap(items.data()!);
      return userModel;
    });
  }

  Future<UserModel> getCurrentUserInfo() async {
    final userId = _authApis.getCurrentUser();
    final result = await _databaseApis.getCurrentUserInfo(uid: userId!.uid);
    UserModel userModel =
        UserModel.fromMap(result.data() as Map<String, dynamic>);
    return userModel;
  }

  Future<void> logout({
    required BuildContext context,
  }) async {
    state = true;
    await GoogleSignIn().signOut();
    final result = await _authApis.logout();
    result.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.signInScreen, (route) => false);
    });
  }

  Future<void> delete({
    required BuildContext context,
  }) async {
    state = true;
    final user = _authApis.getCurrentUser();
    if (user == null) {
      state = false;
      return;
    }
    final uid = user.uid;
    final result2 = await _databaseApis.deleteUserFromCollection(uid: uid);
    result2.fold((l) {
      state = false;
      showSnackBar(context, l.message);
      return;
    }, (r) {});

    final result = await _authApis.deleteUserFomAuth();
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
      return;
    }, (r) async {
      state = false;
      showSnackBar(context, 'Account Deleted Successfully!');
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.signInScreen, (route) => false);
    });
  }

  Stream<User?> getSigninStatusOfUser() {
    return _authApis.getSigninStatusOfUser();
  }
}
