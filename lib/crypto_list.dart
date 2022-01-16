import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:layout/api_service.dart';
import 'package:layout/coin_data.dart';
import 'package:logger/logger.dart';

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

  Future fetchCoinData() async {
    data = await apiService.getCoinData();
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
                fetchCoinData();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: ListView(
        children: List.generate(cDataList.length, (index) {
          return Card(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cDataList[index].name,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(
                      '\$${cDataList[index].price}',
                      style: const TextStyle(fontSize: 23),
                    )
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
