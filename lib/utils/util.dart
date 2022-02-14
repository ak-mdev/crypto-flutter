import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Utils {

  void makeASnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  showAboutDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      width: 380,
      buttonsBorderRadius: BorderRadius.all(const Radius.circular(16)),
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Cryptology v1.0',
      desc: 'Build Date: 2-14-2022\nby Michael May\nIlocode Software',
      btnOkColor: Colors.blueGrey,
      btnOkOnPress: () {},

    ).show();
  }
}