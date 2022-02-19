

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:layout/utils/secret.dart';
import 'package:logger/logger.dart';

class APiService {
  var log = Logger();
  var secret = Secret();

  Future getCoinData(String coinList) async {
    var url = 'https://api.nomics.com/v1/currencies/ticker?key=${secret.accessKey}&ids=$coinList&interval=1d,7d,30d,365d&per-page=120&page=1';
    final response = await http.get(Uri.parse(url));
    List coinData = json.decode(response.body);
    //log.i(response.statusCode);
    //log.i(coinData);
    return coinData;
  }

  Future getCoinBySymbol(String symbol) async {
    var url = 'https://api.nomics.com/v1/currencies/ticker?key=${secret.accessKey}&ids=$symbol&interval=1d,30d&per-page=100&page=1';
    final response = await http.get(Uri.parse(url));
    List coinData = json.decode(response.body);
    log.i(response.statusCode);
    //log.i(coinData);
    return coinData;

  }
}