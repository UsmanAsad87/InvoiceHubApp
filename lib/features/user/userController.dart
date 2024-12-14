import '../../commons/common_imports/apis_commons.dart';
import '../../models/auth_models/user_model.dart';
import '../auth/controller/auth_controller.dart';
import '../auth/controller/auth_notifier_controller.dart';

class UserController{

  refreshUserData(WidgetRef ref) async {
    final authCtr = ref.read(authControllerProvider.notifier);
    UserModel userModel = await authCtr.getCurrentUserInfo();
    final authNotifierProvider = ref.read(authNotifierCtr.notifier);
    authNotifierProvider.setUserModelData(userModel);
  }

}