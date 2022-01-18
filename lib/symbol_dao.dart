
import 'package:floor/floor.dart';
import 'package:layout/symbol.dart';

@dao
abstract class SymbolDao{

  @Query('SELECT * FROM Symbol')
  Stream<List<Symbol>> getAllSymbols();

  @Query('DELETE FROM Symbol WHERE symbol = :symbol')
  Future<void> deleteBySymbol(String symbol);

  @insert
  Future<void> insertSymbol(Symbol symbol);


  @delete
  Future<void> deleteSymbol(Symbol symbol);

}