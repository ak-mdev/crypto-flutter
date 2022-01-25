
import 'package:floor/floor.dart';
import 'package:layout/database/coin_big_data.dart';

@dao
abstract class CoinBigDataDao {
  @Query('SELECT * FROM CoinBigData')
  Stream<List<CoinBigData>> getAllCoins();

  @Query('SELECT * FROM CoinBigData WHERE symbol = :symbol')
  Stream<CoinBigData?> getCoinDataBySymbol(String symbol);

  @Query('DELETE FROM CoinBigData')
  Future<void> deleteAllCoins();

  @Query('DELETE FROM CoinBigData WHERE symbol = :symbol')
  Future<void> deleteCoinBySymbol(String symbol);

  @insert
  Future<void> insertCoin(CoinBigData coinBigData);

  @delete
  Future<void> deleteCoin(CoinBigData coinBigData);
}