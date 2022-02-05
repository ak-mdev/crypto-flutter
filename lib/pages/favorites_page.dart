import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/database/coin_big_data.dart';
import 'package:layout/database/coin_big_data_dao.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:layout/database/provider.dart';

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
    //getFavoritesList(myList);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: FutureBuilder(
        future: coinBigDataDao.getCoinsInFavoritesList(myList.cast()),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            coinList = snapshot.data;
          }
          return ListView.builder(
              itemCount: coinList.length,
              itemBuilder: (context, index) {
                return Text(coinList[index]!.name);
              });
        },
      ),
    );
  }
}
