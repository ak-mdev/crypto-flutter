import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:layout/database/coin_big_data.dart';
import 'package:layout/database/coin_big_data_dao.dart';
import 'package:logger/logger.dart';

class DetailPage extends StatefulWidget {
  final String symbol;

  const DetailPage({Key? key, required this.symbol}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Logger log = Logger();
  final CoinBigDataDao coinBigDataDao = Get.find();
  CoinBigData? coinBigData;

  @override
  Widget build(BuildContext context) {
    var mySymbol = widget.symbol;
    bool isNegative = false;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        actions: [
          IconButton(
              onPressed: () {
                log.i('refresh');
              },
              icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () {
              log.i('Favorite Tap');
          }, icon: const Icon(Icons.favorite_border))
        ],
      ),
      body: StreamBuilder<CoinBigData?> (
        stream: coinBigDataDao.getCoinDataBySymbol(mySymbol),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            coinBigData = snapshot.data;
            coinBigData!.price.contains('-') ? isNegative = true : isNegative = false;


            return Column(
              children: [
                Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${coinBigData?.name}',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),),
                )),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Text(coinBigData!.symbol,
                    style: const TextStyle(
                      fontSize: 25,
                    ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('\$${coinBigData!.price}',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${double.parse(coinBigData!.D1PriceChange)}',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: isNegative ? Colors.red : Colors.green
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${(double.parse(coinBigData!.D1PriceChangePct) * 100).toStringAsFixed(2)}%',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: isNegative ? Colors.red : Colors.green
                    ),),
                ),

              ],
            );

          }
          return const Center(child: CircularProgressIndicator());

        },

      ),
    );
  }
}
