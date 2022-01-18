import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:layout/add_symbol.dart';
import 'package:layout/api_service.dart';
import 'package:layout/coin_data.dart';
import 'package:layout/symbol.dart';
import 'package:logger/logger.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'database/database.dart';

class CryptoListPage extends StatefulWidget {
  const CryptoListPage({Key? key}) : super(key: key);

  @override
  _CryptoListPageState createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  var log = Logger();
  var apiService = APiService();
  List data = [];
  List<CoinData> cDataList = [];
  List<String> symbolList = [];

  Future getSymbolList() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('my_database.db').build();
    final symbolDao = database.symbolDao;
    Stream<List<Symbol>> myData = symbolDao.getAllSymbols();
    myData.listen((event) {
      symbolList.clear();
      for (var item in event) {
        symbolList.add(item.symbol);
      }
      //Converts list to String
      String convertedList = symbolList.join(',');
      log.i(convertedList);
      fetchCoinData(convertedList); //Passes CoinList String to FetchCoinData
    });
  }

  Future fetchCoinData(String coinList) async {
    data = await apiService.getCoinData(coinList);
    var price = data[0]['price'];
    cDataList.clear();
    log.i(price);

    for (var i = 0; i < data.length; i++) {
      String id = data[i]['id'];
      String price = data[i]['price'];
      String symbol = data[i]['symbol'];
      String name = data[i]['name'];
      String logoUrl = data[i]['logo_url'];
      String timeStamp = data[i]['price_timestamp'];
      double priceD = double.parse(price);
      priceD > 0.01 ? price = priceD.toStringAsFixed(2) : price = price;

      cDataList.add(CoinData(
          id: id,
          price: price,
          symbol: symbol,
          name: name,
          logoUrl: logoUrl,
          timeStamp: timeStamp));
    }

    setState(() {
      cDataList;
    });
  }

  @override
  void initState() {
    super.initState();
    //apiService.getCoinData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cryptology'),
        actions: [
          IconButton(
              onPressed: () {
                getSymbolList(); // get symbol list from local db
              },
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddSymbolPage()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView(
        children: List.generate(cDataList.length, (index) {
          final item = cDataList[index];
          return Dismissible(
            key: Key('$item'),
            onDismissed: (direction) async {
              final database =
              await $FloorAppDatabase.databaseBuilder('my_database.db').build();
              var id = int.parse(cDataList[index].id);
              final symbolDao = database.symbolDao;
              symbolDao.deleteSymbol(Symbol(symbol: item.symbol));
              
              setState(() {
                symbolDao.deleteSymbol(Symbol(id: id, symbol: item.symbol));
              });
            },
            child: Card(
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: cDataList[index].logoUrl.contains('svg')
                                ? SvgPicture.network(
                                    cDataList[index].logoUrl,
                                    semanticsLabel: cDataList[index].symbol,
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    cDataList[index].logoUrl,
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            cDataList[index].symbol,
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
                          cDataList[index].name,
                          style: const TextStyle(fontSize: 30),
                          overflow: TextOverflow.fade,
                        ),
                        Text(
                          '\$${cDataList[index].price}',
                          style: const TextStyle(fontSize: 23),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
