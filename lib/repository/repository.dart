import 'package:get/get.dart';
import 'package:layout/database/coin_big_data.dart';
import 'package:layout/database/coin_big_data_dao.dart';
import 'package:layout/network/api_service.dart';

class MyRepository {
  Future refreshData() async {
    final CoinBigDataDao coinBigDataDao = Get.find();
    List data = [];

    final apiService = APiService();
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
}
