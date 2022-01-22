import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:layout/add_symbol.dart';
import 'package:layout/api_service.dart';
import 'package:layout/symbol.dart';
import 'package:layout/symbol_dao.dart';
import 'package:logger/logger.dart';

import 'coin_data.dart';

class CryptoList2Page extends StatefulWidget {
  const CryptoList2Page({Key? key}) : super(key: key);

  @override
  _CryptoListPageState createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoList2Page> {
  var log = Logger();
  final SymbolDao symbolDao = Get.find();
  List<Symbol> symbols = [];
  List<String> symbolList = [];
  List<CoinData> coinDataList = [];
  List myCoinData = [];

  final apiService = APiService();

  @override
  void initState() {
    super.initState();
    //getSymbolData();
  }

  /*Future fetchCoinData(String coinList) async {
    myCoinData = await apiService.getCoinData(coinList);
    var price = myCoinData[0]['price'];
    coinDataList.clear();
    log.i(price);

    for (var i = 0; i < myCoinData.length; i++) {
      String id = myCoinData[i]['id'];
      String price = myCoinData[i]['price'];
      String symbol = myCoinData[i]['symbol'];
      String name = myCoinData[i]['name'];
      String logoUrl = myCoinData[i]['logo_url'];
      String timeStamp = myCoinData[i]['price_timestamp'];
      double priceD = double.parse(price);
      priceD > 0.01 ? price = priceD.toStringAsFixed(2) : price = price;

      coinDataList.add(CoinData(
          id: id,
          price: price,
          symbol: symbol,
          name: name,
          logoUrl: logoUrl,
          timeStamp: timeStamp));
    }

    setState(() {
      coinDataList;
    });
  }*/

  convertSymbolListToString(List<String> symbolList) {
    String convertedList = symbolList.join(',');
    log.i(convertedList);
    return convertedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cryptology'),
          actions: [
            IconButton(
                onPressed: () {
                  //getSymbolList(); // get symbol list from local db
                },
                icon: const Icon(Icons.refresh)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddSymbolPage()));
                },
                icon: const Icon(Icons.add)),
            IconButton(onPressed: () {

            }, icon: const Icon(Icons.delete))
          ],
        ),
        body: StreamBuilder<List<Symbol>>(
            stream: symbolDao.getAllSymbols(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                symbols = snapshot.requireData;
                symbolList.clear();
                for (var i = 0; i < symbols.length; i++) {
                  symbolList.add(symbols[i].symbol);
                }

                String coins = convertSymbolListToString(symbolList);
                log.i('XXX ${convertSymbolListToString(symbolList)}');

                return FutureBuilder(
                    future: apiService.getCoinData(coins),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        myCoinData = snapshot.requireData as List<dynamic>;
                        return ListView.builder(
                            itemCount: myCoinData.length,
                            itemBuilder: (context, index) {
                              return coinCard(index);
                            });
                      }
                      return const CircularProgressIndicator();
                    });
              }
              return const CircularProgressIndicator();
            }));
  }

  Card coinCard(int index) {
    return Card(
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: myCoinData[index]['logo_url'].contains('svg')
                        ? SvgPicture.network(
                            myCoinData[index]['logo_url'],
                            semanticsLabel: myCoinData[index]['symbol'],
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            myCoinData[index]['logo_url'],
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                          )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    myCoinData[index]['symbol'],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  myCoinData[index]['name'],
                  style: const TextStyle(fontSize: 30),
                  overflow: TextOverflow.fade,
                ),
                Text(
                  '\$${myCoinData[index]['price']}',
                  style: const TextStyle(fontSize: 23),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
