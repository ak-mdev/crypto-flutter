import 'package:get/get.dart';
import 'package:layout/database/coin_big_data.dart';
import 'package:layout/database/coin_big_data_dao.dart';
import 'package:layout/network/api_service.dart';
import 'package:layout/utils/util.dart';
import 'package:logger/logger.dart';

class MyRepository {
  Future refreshData() async {
    final CoinBigDataDao coinBigDataDao = Get.find();
    List data = [];
    var log = Logger();
    var utils = Utils();

    final apiService = APiService();
    data = await apiService.getCoinData('');
    coinBigDataDao.deleteAllCoins();



    for (int i = 0; i < data.length; i++) {

      String symbol = data[i]['symbol'] ?? 'not available';
      String name = data[i]['name'] ?? 'not available';
      String logoUrl = data[i]['logo_url'] ?? 'not available';
      String status = data[i]['status'] ?? 'not available';
      String price = data[i]['price'] ?? 'not available';
      String timestamp = data[i]['price_timestamp'] ?? 'not available';
      String circulatingSupply = data[i]['circulating_supply'] ?? 'not available';
      String maxSupply = data[i]['max_supply'] ?? 'not available';
      String rank = data[i]['rank'] ?? 'not available';
      String high = data[i]['high'] ?? 'not available';
      String highTimestamp = data[i]['high_timestamp'] ?? 'not available';
      String d1Volume = data[i]['1d']['volume'] ?? 'not available';
      String d1PriceChange = data[i]['1d']['price_change'] ?? 'not available';
      String d1PriceChangePct = data[i]['1d']['price_change_pct'] ?? 'not available';
      String d1VolChange = data[i]['1d']['volume_change'] ?? 'not available';
      String d1VolChangeOct = data[i]['1d']['volume_change_pct'] ?? 'not available';
      String d7Volume = data[i]['7d']['volume'] ?? 'not available';
      String d7PriceChange = data[i]['7d']['price_change'] ?? 'not available';
      String d7PriceChangePct = data[i]['7d']['price_change_pct'] ?? 'not available';
      String d7VolChange = data[i]['7d']['volume_change'] ?? 'not available';
      String d7VolChangeOct = data[i]['7d']['volume_change_pct'] ?? 'not available';
      String d30Volume = data[i]['30d']['volume'] ?? 'not available';
      String d30PriceChange = data[i]['30d']['price_change'] ?? 'not available';
      String d30PriceChangePct = data[i]['30d']['price_change_pct'] ?? 'not available';
      String d30VolChange = data[i]['30d']['volume_change']  ?? 'not available';
      String d30VolChangePct = data[i]['30d']['volume_change_pct'] ?? 'not available';
      String d365Volume = data[i]['365d']['volume'] ?? 'not available';
      String d365PriceChange = data[i]['365d']['price_change'] ?? 'not available';
      String d365PriceChangePct = data[i]['365d']['price_change_pct']  ?? 'not available';
      String d365VolChange = data[i]['365d']['volume_change'] ?? 'not available';
      String d365VolChangePct = data[i]['365d']['volume_change_pct'] ?? 'not available';

      timestamp = utils.convertUTC(timestamp).toString();




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
          D7Volume: d7Volume,
          D7PriceChange: d7PriceChange,
          D7PriceChangePct: d7PriceChangePct,
          D7VolChange: d7VolChange,
          D7VolChangeOct: d7VolChangeOct,
          D30Volume: d30Volume,
          D30PriceChange: d30PriceChange,
          D30PriceChangePct: d30PriceChangePct,
          D30VolChange: d30VolChange,
          D30VolChangePct: d30VolChangePct,
          D365Volume: d365Volume,
          D365PriceChange: d365PriceChange,
          D365PriceChangePct: d365PriceChangePct,
          D365VolChange: d365VolChange,
          D365VolChangePct: d365VolChangePct);

      coinBigDataDao.insertCoin(newInsert);
    }
  }
}
