import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_task/config/routes/app_route.dart';
import 'package:flutter_task/core/cache/user_cache.dart';
import 'package:flutter_task/core/exception/api_exception.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/models/failure.dart';
import 'package:flutter_task/core/widgets/alert_ui.dart';
import 'package:flutter_task/features/registration/model/registration_repository.dart';
import 'package:flutter_task/features/registration/model/user_model.dart';

class RegistrationViewModel {
  ///objects
  GenericCubit<bool> passwordSecureCubit = GenericCubit(true);
  GenericCubit<bool> confirmPasswordSecureCubit = GenericCubit(true);
  GenericCubit<UserModel?> registerCubit = GenericCubit(null);
  RegistrationRepository repository = RegistrationRepository();

  ///methods
  Future<void> registerAccount(BuildContext context,
      {required String username,
      required String email,
      required String firstName,
      required String lastName,
      required String password}) async {
    registerCubit.onLoadingState();
    try {
      final userResponse = await repository.registerAccount(
          username: username,
          password: password,
          email: email,
          firstName: firstName,
          lastName: lastName);
      cacheUserData(userResponse.user);
      registerCubit.onUpdateData(userResponse);
      if (context.mounted) {
        showAlertMessage(context,
            message: userResponse.message, type: MessageType.success);
      }
    } on ApiException catch (failure) {
      // show toast with error message
      if (context.mounted) {
        showAlertMessage(context,
            message: failure.error, type: MessageType.error);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.loginPage, (route) => false);
      }

      registerCubit.onErrorState(Failure(message: failure.error));
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

  void cacheUserData(User user) {
    UserPrefCache.saveCurrentUser(json.encode(user.toJson()));
  }
}
