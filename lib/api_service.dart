

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class APiService {
  var log = Logger();
  var apiKey = 'e2927c2de61962e52b76c9625c78ed7c7631ce18';


  Future getCoinData(String coinList) async {
    var url = 'https://api.nomics.com/v1/currencies/ticker?key=$apiKey&ids=$coinList&interval=1d,30d&per-page=100&page=1';
    final response = await http.get(Uri.parse(url));
    List coinData = json.decode(response.body);
    log.i(response.statusCode);
    //log.i(coinData);
    return coinData;
  }

  Future getCoinBySymbol(String symbol) async {
    var url = 'https://api.nomics.com/v1/currencies/ticker?key=$apiKey&ids=$symbol&interval=1d,30d&per-page=100&page=1';
    final response = await http.get(Uri.parse(url));
    List coinData = json.decode(response.body);
    log.i(response.statusCode);
    //log.i(coinData);
    return coinData;

  }
}