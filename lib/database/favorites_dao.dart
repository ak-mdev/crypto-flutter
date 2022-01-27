
import 'package:floor/floor.dart';
import 'package:layout/database/coin_big_data.dart';
import 'package:layout/model/symbol_data.dart';


@dao
abstract class FavoritesDao {
  @Query('SELECT * FROM SymbolData')
  Future<List<SymbolData>> getAllFavorites();

  @insert
  Future<void> insertFavorite(SymbolData symbolData);

  @Query('DELETE FROM SymbolData')
  Future<void> deleteAllFavorites();

  @Query('DELETE FROM SymbolData WHERE sym = :symbol')
  Future<void> deleteFavoriteBySymbol(String symbol);

}
