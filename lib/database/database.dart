import 'dart:async';

import 'package:floor/floor.dart';
import 'package:layout/symbol.dart';
import 'package:layout/symbol_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Symbol])
abstract class AppDatabase extends FloorDatabase {
  SymbolDao get symbolDao;
}
