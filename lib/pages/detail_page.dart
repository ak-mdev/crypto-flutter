import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:layout/database/coin_big_data.dart';
import 'package:layout/database/coin_big_data_dao.dart';
import 'package:layout/database/favorites_dao.dart';
import 'package:layout/model/symbol_data.dart';
import 'package:layout/repository/repository.dart';
import 'package:logger/logger.dart';

class DetailPage extends StatefulWidget {
  final String symbol;

  const DetailPage({Key? key, required this.symbol}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Logger log = Logger();
  var repository = MyRepository();
  final CoinBigDataDao coinBigDataDao = Get.find();
  final FavoritesDao favoritesDao = Get.find();
  CoinBigData? coinBigData;


  List<String> symbols = [];

  bool favIsSelected = false;

  @override
  void initState() {
    super.initState();
    getFavoriteState(widget.symbol);
  }

  Future getFavoriteState(String mySymbol) async {
    List<SymbolData> symbolData = [];
    symbolData = favoritesDao.getAllFavorites() as List<SymbolData>;
    symbols.clear();
    for (int i = 0; i < symbolData.length; i++) {
      String symbol = symbolData[i].sym;
      symbols.add(symbol);
    }

    log.i(symbols);
    symbols.contains(mySymbol) ? favIsSelected = true : favIsSelected = false;

    setState(() {
      favIsSelected;
      log.i(favIsSelected);
    });
  }

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
                  repository.refreshData();
                },
                icon: const Icon(Icons.refresh)),
            IconButton(
                onPressed: () async {
                  log.i(symbols);
                  if (favIsSelected) {
                    await favoritesDao.deleteFavoriteBySymbol(mySymbol);
                    getFavoriteState(mySymbol);
                  } else {
                    await favoritesDao.insertFavorite(SymbolData(sym: mySymbol));
                    getFavoriteState(mySymbol);

                  }
                },
                icon: favIsSelected
                    ? const Icon(Icons.favorite)
                    : const Icon((Icons.favorite_border)))
          ],
        ),
        body: StreamBuilder<CoinBigData?>(
            stream: coinBigDataDao.getCoinDataBySymbol(mySymbol),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                coinBigData = snapshot.data;
                coinBigData!.price.contains('-')
                    ? isNegative = true
                    : isNegative = false;

                return Stack(
                  children: [
                    logoImage(),
                    glassLayer(),
                    InfoLayer(coinBigData: coinBigData)
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  GlassmorphicContainer glassLayer() {
    return GlassmorphicContainer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 0,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0x20FFFFFF).withOpacity(0.2),
            const Color(0x20FFFFFF).withOpacity(0.2)
          ],
        ),
        border: 1,
        blur: 2,
        borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0x20FFFFFF).withOpacity(0.1),
              const Color(0x20FFFFFF).withOpacity(0.1)
            ]));
  }

  SizedBox logoImage() {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: coinBigData!.logoUrl.contains('svg')
            ? SvgPicture.network(
                coinBigData!.logoUrl,
                semanticsLabel: coinBigData!.symbol,
                width: 250,
                height: 250,
                fit: BoxFit.fitWidth,
              )
            : Image.network(
                coinBigData!.logoUrl,
                width: 250,
                height: 250,
                fit: BoxFit.fitWidth,
              ));
  }
}

class InfoLayer extends StatelessWidget {
  const InfoLayer({
    Key? key,
    required this.coinBigData,
  }) : super(key: key);

  final CoinBigData? coinBigData;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TitleCard(coinBigData: coinBigData),
        oneDayCard(),
        thirtyDayCard()
      ],
    );
  }

  Padding oneDayCard() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        color: const Color(0xffFFFFFF).withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  '1 Day',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Text(
                'Change: ${(double.parse(coinBigData!.D1PriceChangePct) * 100).toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                'Change: \$${coinBigData!.D1PriceChange}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                'Volume: ${coinBigData!.D1Volume}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Text(
                'Vol Change: ${(double.parse(coinBigData!.D1VolChangeOct) * 100).toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding thirtyDayCard() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        color: const Color(0xffFFFFFF).withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  '30 Day',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Text(
                'Change: ${(double.parse(coinBigData!.D30PriceChangePct) * 100).toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                'Change: \$${coinBigData!.D30PriceChange}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                'Volume: ${coinBigData!.D30Volume}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Text(
                'Vol Change: ${(double.parse(coinBigData!.D30VolChangePct) * 100).toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleCard extends StatelessWidget {
  const TitleCard({
    Key? key,
    required this.coinBigData,
  }) : super(key: key);

  final CoinBigData? coinBigData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        color: const Color(0xffFFFFFF).withOpacity(0.8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                coinBigData!.name,
                style: const TextStyle(fontSize: 35),
              ),
            ),
            Text(
              coinBigData!.symbol,
              style: const TextStyle(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                '\$${coinBigData!.price}',
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
