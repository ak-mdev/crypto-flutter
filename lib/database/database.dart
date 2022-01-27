import 'dart:async';

import 'package:floor/floor.dart';
import 'package:layout/database/coin_big_data.dart';
import 'package:layout/database/favorites_dao.dart';
import 'package:layout/model/symbol_data.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

import 'coin_big_data_dao.dart';

part 'database.g.dart';

//packages pub run build_runner build

@Database(version: 1, entities: [CoinBigData, SymbolData])
abstract class AppDatabase extends FloorDatabase {
  FavoritesDao get favoritesDao;
  CoinBigDataDao get coinBigDataDao;

}
