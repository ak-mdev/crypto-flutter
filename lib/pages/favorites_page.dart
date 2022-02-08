import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/database/coin_big_data_dao.dart';
import 'package:layout/database/provider.dart';
import 'package:layout/pages/detail_page.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../repository/repository.dart';
import '../util.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  var log = Logger();
  List<String> symList = [];
  final box = GetStorage();
  List myList = [];
  List coinList = [];
  final CoinBigDataDao coinBigDataDao = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myList = context.watch<ListProvider>().symList;
    bool isNegative = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder(
        future: coinBigDataDao.getCoinsInFavoritesList(myList.cast()),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            coinList = snapshot.data;
          }
          return RefreshIndicator(
            onRefresh: () {
              var utils = Utils();
              var repository = MyRepository();
              utils.makeASnackBar('Refreshing Data', context);
              return repository.refreshData();
            },
            child: ListView.builder(
                itemCount: coinList.length,
                itemBuilder: (context, index) {
                  coinList[index].D1PriceChangePct.contains('-')
                      ? isNegative = true
                      : isNegative = false;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(symbol: coinList[index].symbol)));
                    },
                    child: Card(
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
                                    child: coinList[index].logoUrl.contains('svg')
                                        ? SvgPicture.network(
                                            coinList[index].logoUrl,
                                            semanticsLabel:
                                                coinList[index].symbol,
                                            width: 75,
                                            height: 75,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            coinList[index].logoUrl,
                                            width: 75,
                                            height: 75,
                                            fit: BoxFit.cover,
                                          )),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    coinList[index].symbol,
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
                                coinList[index].name,
                                style: const TextStyle(fontSize: 30),
                                overflow: TextOverflow.fade,
                              ),
                              Text(
                                '\$${coinList[index].price}',
                                style: const TextStyle(fontSize: 23),
                              ),
                              Text(
                                '${(double.parse(coinList[index].D1PriceChangePct) * 100).toStringAsFixed(2)}%',
                                style: TextStyle(
                                    color: isNegative ? Colors.red : Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
