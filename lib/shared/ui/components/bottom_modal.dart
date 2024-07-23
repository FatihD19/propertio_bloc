// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_single_cascade_in_expression_statements

import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showMessageModal(BuildContext context, String message, {Color? color}) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: color != null ? color : Colors.red,
    duration: const Duration(seconds: 1),
  ).show(context);
}

void confirmDialog(
    BuildContext context, String title, String message, Function() onConfirm) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.scale,
    title: '$title',
    desc: '$message',
    btnCancelText: 'Batal',
    btnOkOnPress: () {
      onConfirm();
    },
    btnCancelOnPress: () {},
  )..show();
}

void errorDialog(BuildContext context, String message, String title,
    {Function()? onConfirm}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.scale,
    title: '$message',
    btnCancelText: 'Batal',
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      onConfirm!();
    },
  ).show();
}

void succsessDialog(
    BuildContext context, String message, Function() onConfirm) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.scale,
    title: '$message',
    btnOkOnPress: () {
      onConfirm();
    },
  ).show();
}

void showCustomSnackbar(BuildContext context, Widget content,
    {String? type, bool? isProperti}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Container(
              // height: 800,
              child: Container(
                  // height: MediaQuery.of(context).size.height * 0.55,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0),
                    ),
                  ),
                  child: content)));
    },
  );
}
