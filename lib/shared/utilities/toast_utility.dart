import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:tebbi/configs/app_colors.dart";

showToast({required String message, Toast? length, required bool isError}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: isError ? Colors.red : AppColors.primary,
    toastLength: length ?? Toast.LENGTH_LONG,
    textColor: isError ? AppColors.secondary : AppColors.primary,
    fontSize: 16.0,
  );
}
