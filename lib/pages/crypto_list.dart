import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:layout/database/coin_big_data.dart';
import 'package:layout/database/coin_big_data_dao.dart';
import 'package:layout/model/symbol.dart';
import 'package:layout/network/api_service.dart';
import 'package:layout/pages/add_symbol.dart';
import 'package:logger/logger.dart';

class CryptoListPage extends StatefulWidget {
  const CryptoListPage({Key? key}) : super(key: key);

  @override
  _CryptoListPageState createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  var log = Logger();

  //final SymbolDao symbolDao = Get.find();
  final CoinBigDataDao coinBigDataDao = Get.find();
  List<Symbol> symbols = [];
  List<String> symbolList = [];

  List myCoinData = [];
  List data = [];
  List<CoinBigData> coins = [];

  final apiService = APiService();

  @override
  void initState() {
    refreshData();
    super.initState();
  }

  Future refreshData() async {
    data = await apiService.getCoinData('');
    coinBigDataDao.deleteAllCoins();

    for (int i = 0; i < data.length; i++) {
      String symbol = data[i]['symbol'];
      String name = data[i]['name'];
      String logoUrl = data[i]['logo_url'];
      String status = data[i]['status'];
      String price = data[i]['price'];
      String timestamp = data[i]['price_timestamp'];
      String circulatingSupply = data[i]['circulating_supply'];
      String maxSupply = data[i]['max_supply'] ?? 'na';
      String rank = data[i]['rank'];
      String high = data[i]['high'];
      String highTimestamp = data[i]['high_timestamp'];
      String d1Volume = data[i]['1d']['volume'];
      String d1PriceChange = data[i]['1d']['price_change'];
      String d1PriceChangePct = data[i]['1d']['price_change_pct'];
      String d1VolChange = data[i]['1d']['volume_change'];
      String d1VolChangeOct = data[i]['1d']['volume_change_pct'];
      String d30Volume = data[i]['30d']['volume'];
      String d30PriceChange = data[i]['30d']['price_change'];
      String d30PriceChangePct = data[i]['30d']['price_change_pct'];
      String d30VolChange = data[i]['30d']['volume_change'];
      String d30VolChangePct = data[i]['30d']['volume_change_pct'];

      var newInsert = CoinBigData(
          symbol: symbol,
          name: name,
          logoUrl: logoUrl,
          status: status,
          price: price,
          timestamp: timestamp,
          circulatingSupply: circulatingSupply,
          maxSupply: maxSupply,
          rank: rank,
          high: high,
          highTimestamp: highTimestamp,
          D1Volume: d1Volume,
          D1PriceChange: d1PriceChange,
          D1PriceChangePct: d1PriceChangePct,
          D1VolChange: d1VolChange,
          D1VolChangeOct: d1VolChangeOct,
          D30Volume: d30Volume,
          D30PriceChange: d30PriceChange,
          D30PriceChangePct: d30PriceChangePct,
          D30VolChange: d30VolChange,
          D30VolChangePct: d30VolChangePct);

      coinBigDataDao.insertCoin(newInsert);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cryptology'),
          actions: [
            IconButton(
                onPressed: () {
                  refreshData();
                },
                icon: const Icon(Icons.refresh)),

          ],
        ),
        body: StreamBuilder<List<CoinBigData>>(
            stream: coinBigDataDao.getAllCoins(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                //log.i("xxxx ${snapshot.data}");
                coins.clear();
                coins = snapshot.data!;
                return ListView.builder(
                    itemCount: coins.length,
                    itemBuilder: (context, index) {
                      return coinCard(index, coins);
                    });
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}

Card coinCard(int index, List<CoinBigData> coins) {
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
                  child: coins[index].logoUrl.contains('svg')
                      ? SvgPicture.network(
                          coins[index].logoUrl,
                          semanticsLabel: coins[index].symbol,
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          coins[index].logoUrl,
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                        )),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  coins[index].symbol,
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
                coins[index].name,
                style: const TextStyle(fontSize: 30),
                overflow: TextOverflow.fade,
              ),
              Text(
                '\$${coins[index].price}',
                style: const TextStyle(fontSize: 23),
              )
            ],
          ),
        )
      ],
    ),
  );
}
