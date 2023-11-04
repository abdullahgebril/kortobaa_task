import 'package:easy_localization/easy_localization.dart';

class FormValidation {
  static String? userNameFormValidation(String? value) {
    if (value!.isEmpty) {
      return "userName_is_required".tr();
    }
    return null;
  }

  static String? passwordFormValidation(String? value) {
    if (value!.isEmpty) {
      return "password_is_required".tr();
    }
    return null;
  }

  static String? confirmPasswordFormValidation(String? value, String text) {
    if (value!.isEmpty) {
      return "password_is_required".tr();
    }
    if (value != text) {
      return "not_match".tr();
    }
    return null;
  }

  static String? validateFormEmail(String? email) {
    if (email!.isEmpty) {
      return "email_is_requires".tr();
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) {
      return "email_is_requires".tr();
    }
    return null;
  }
}
