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
  //List<CoinData> coinDataList = [];
  List myCoinData = [];

  final apiService = APiService();

  @override
  void initState() {
    super.initState();
  }

  convertSymbolListToString(List<String> symbolList) {
    String convertedList = symbolList.join(',');
    log.i(convertedList);
    return convertedList;
  }

  Future deleteSymbolFromDB(String symbol) async {
    await symbolDao.deleteBySymbol(symbol);
  }

  Future refreshData(var coinDataList) async {
    apiService.getCoinData(convertSymbolListToString(coinDataList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cryptology'),
          actions: [
            IconButton(onPressed: () {
              //refreshData(coinDataList);
            },  icon: const Icon(Icons.refresh)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddSymbolPage()));
                },
                icon: const Icon(Icons.add)),
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

                return FutureBuilder(
                    future: apiService.getCoinData(coins),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        myCoinData = snapshot.requireData as List<dynamic>;
                        return ListView.builder(
                            itemCount: myCoinData.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                 // key: Key('item ${myCoinData[index]}'),
                                  key: UniqueKey(),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) {
                                    setState(() {
                                    //  coinDataList.removeAt(index);
                                     // symbolList.removeAt(index);
                                      deleteSymbolFromDB('${myCoinData[index]['symbol']}');

                                    });

                                  },
                                  child: coinCard(index));
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
