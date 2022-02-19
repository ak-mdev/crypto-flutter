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
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(16)),
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Cryptology v1.0',
      desc: 'Build Date: 2-14-2022\nby Michael May\nIlocode Software',
      btnOkColor: Colors.blueGrey,
      btnOkOnPress: () {},
    ).show();
  }

  convertUTC(String timeStamp, bool isShowingTime) {
    late String dateStr;
    timeStamp = timeStamp.replaceAll('Z', '');
    timeStamp = timeStamp.replaceAll('T', ' ');
    var dateTime = DateFormat('yyyy-MM-dd hh:mm:ss').parse(timeStamp, true);
    dateTime = dateTime.toLocal();
    var year = dateTime.year;
    var month = dateTime.month;
    var day = dateTime.day;
    var hour = dateTime.hour;
    var minute = dateTime.minute;
    //log.i(dateTime.toLocal());
    if (isShowingTime) {
      dateStr = '$month-$day-$year $hour:$minute';
    } else {
      dateStr = '$month-$day-$year';
    }
    return dateStr;
  }

  calculateSupplyPercentage(String maxSupply, String circulatingSupply) {
    double max = double.parse(maxSupply);
    double circ = double.parse(circulatingSupply);
    if (max == 0.0) {
      return '-0-';
    } else {
      double supplyPctD = circ / max;
      //log.i('max: $max - circ: $circ - pct: $supplyPctD');
      supplyPctD = supplyPctD * 100;
      return supplyPctD.toStringAsFixed(0);
    }
  }

  calculatePercentFromHigh(String highPrice, String currentPrice) {
    double high = double.parse(highPrice);
    double current = double.parse(currentPrice);
    double pctFromHighD = (1 - (current / high));
    pctFromHighD = pctFromHighD * 100;
    return pctFromHighD.toStringAsFixed(0);
  }
}
