import 'dart:async';

import 'package:floor/floor.dart';
import 'package:layout/database/coin_big_data.dart';
import 'package:layout/model/symbol.dart';
import 'package:layout/database/symbol_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'coin_big_data_dao.dart';

part 'database.g.dart';

//packages pub run build_runner build

@Database(version: 1, entities: [CoinBigData])
abstract class AppDatabase extends FloorDatabase {
  //SymbolDao get symbolDao;
  CoinBigDataDao get coinBigDataDao;

}
