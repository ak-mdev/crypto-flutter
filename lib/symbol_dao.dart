
import 'package:floor/floor.dart';
import 'package:layout/symbol.dart';

@dao
abstract class SymbolDao{

  @Query('SELECT * FROM Symbol')
  Stream<List<Symbol>> getAllSymbols();

  @insert
  Future<void> insertSymbol(Symbol symbol);

  @delete
  Future<void> deleteSymbol(Symbol symbol);

}