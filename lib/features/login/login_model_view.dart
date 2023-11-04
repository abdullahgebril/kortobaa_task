import 'package:flutter/material.dart';
import 'package:flutter_task/config/routes/app_route.dart';
import 'package:flutter_task/core/cache/user_pref_manager.dart';
import 'package:flutter_task/core/exception/api_exception.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/models/failure.dart';
import 'package:flutter_task/core/widgets/alert_ui.dart';
import 'package:flutter_task/features/login/model/login_repository.dart';
import 'package:flutter_task/features/login/model/token_model.dart';

class LoginViewModel {
  ///objects
  GenericCubit<bool> passwordSecureCubit = GenericCubit(true);
  GenericCubit<TokenModel?> loginCubit = GenericCubit(null);
  LoginRepository repository = LoginRepository();

  ///methods
  Future<void> login(BuildContext context,
      {required String userName, required String password}) async {
    loginCubit.onLoadingState();
    try {
      final userResponse = await repository.login(userName, password);
      loginCubit.onUpdateData(userResponse);
      UserPrefManager.saveCurrentUserAccessToken(userResponse.access);
      UserPrefManager.saveCurrentUserAccessToken(userResponse.refresh);

      if (context.mounted) {
        showAlertMessage(context,
            message: "Login Success", type: MessageType.success);
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.navigationScreen, (route) => false);
      }
    } on ApiException catch (failure) {
      // show toast with error message
      if (context.mounted) {
        showAlertMessage(context,
            message: failure.error, type: MessageType.error);
      }

      loginCubit.onErrorState(Failure(message: failure.error));
    }
  }

  showAlertMessage(BuildContext context,
      {required String message, required MessageType type}) {
    AlertUI.showAlert(
      context,
      message: message,
      type: type,
    );
  }
}
