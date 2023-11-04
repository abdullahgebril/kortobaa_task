import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toastification/toastification.dart';

class AlertUI {
  static void showAlert(context, {message, type}) {
    Toastification().show(
      context: context,
      title: "Status",
      description: message ?? "",
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 2),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      backgroundColor: type == MessageType.error
          ? Colors.black
          : type == MessageType.success
              ? Colors.green[200]
              : type == MessageType.warning
                  ? Colors.amber
                  : Colors.green[200],
    );
  }

  static void showFlutterToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorResources.primaryColor,
        textColor: Colors.white,
        fontSize: 18.0.sp);
  }

  static Widget askToDeleteItem(BuildContext context,
      {required VoidCallback deletePressed}) {
    return CupertinoAlertDialog(
      title: Text("delete".tr()),
      content: Text("askToDelete".tr()),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: deletePressed,
          child: Text("delete".tr()),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: Text("cancel".tr()),
        )
      ],
    );
  }
}

enum MessageType { error, success, warning }
