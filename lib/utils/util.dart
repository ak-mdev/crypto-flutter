import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class Utils {
  Logger log = Logger();

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

  convertUTC(String timeStamp) {
    timeStamp = timeStamp.replaceAll('Z', '');
    timeStamp = timeStamp.replaceAll('T', ' ');
    var dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(timeStamp, true);
    log.i(dateTime.toLocal());
    return dateTime.toLocal();
  }
}