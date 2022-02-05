// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FavoritesDao? _favoritesDaoInstance;

  CoinBigDataDao? _coinBigDataDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CoinBigData` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `symbol` TEXT NOT NULL, `name` TEXT NOT NULL, `logoUrl` TEXT NOT NULL, `status` TEXT NOT NULL, `price` TEXT NOT NULL, `timestamp` TEXT NOT NULL, `circulatingSupply` TEXT NOT NULL, `maxSupply` TEXT NOT NULL, `rank` TEXT NOT NULL, `high` TEXT NOT NULL, `highTimestamp` TEXT NOT NULL, `D1Volume` TEXT NOT NULL, `D1PriceChange` TEXT NOT NULL, `D1PriceChangePct` TEXT NOT NULL, `D1VolChange` TEXT NOT NULL, `D1VolChangeOct` TEXT NOT NULL, `D30Volume` TEXT NOT NULL, `D30PriceChange` TEXT NOT NULL, `D30PriceChangePct` TEXT NOT NULL, `D30VolChange` TEXT NOT NULL, `D30VolChangePct` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SymbolData` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `sym` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FavoritesDao get favoritesDao {
    return _favoritesDaoInstance ??= _$FavoritesDao(database, changeListener);
  }

  @override
  CoinBigDataDao get coinBigDataDao {
    return _coinBigDataDaoInstance ??=
        _$CoinBigDataDao(database, changeListener);
  }
}

class _$FavoritesDao extends FavoritesDao {
  _$FavoritesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _symbolDataInsertionAdapter = InsertionAdapter(
            database,
            'SymbolData',
            (SymbolData item) =>
                <String, Object?>{'id': item.id, 'sym': item.sym});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SymbolData> _symbolDataInsertionAdapter;

  @override
  Future<List<SymbolData>> getAllFavorites() async {
    return _queryAdapter.queryList('SELECT * FROM SymbolData',
        mapper: (Map<String, Object?> row) =>
            SymbolData(id: row['id'] as int?, sym: row['sym'] as String));
  }

  @override
  Future<void> deleteAllFavorites() async {
    await _queryAdapter.queryNoReturn('DELETE FROM SymbolData');
  }

  @override
  Future<void> deleteFavoriteBySymbol(String symbol) async {
    await _queryAdapter.queryNoReturn('DELETE FROM SymbolData WHERE sym = ?1',
        arguments: [symbol]);
  }

  @override
  Future<void> insertFavorite(SymbolData symbolData) async {
    await _symbolDataInsertionAdapter.insert(
        symbolData, OnConflictStrategy.abort);
  }
}

class _$CoinBigDataDao extends CoinBigDataDao {
  _$CoinBigDataDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _coinBigDataInsertionAdapter = InsertionAdapter(
            database,
            'CoinBigData',
            (CoinBigData item) => <String, Object?>{
                  'id': item.id,
                  'symbol': item.symbol,
                  'name': item.name,
                  'logoUrl': item.logoUrl,
                  'status': item.status,
                  'price': item.price,
                  'timestamp': item.timestamp,
                  'circulatingSupply': item.circulatingSupply,
                  'maxSupply': item.maxSupply,
                  'rank': item.rank,
                  'high': item.high,
                  'highTimestamp': item.highTimestamp,
                  'D1Volume': item.D1Volume,
                  'D1PriceChange': item.D1PriceChange,
                  'D1PriceChangePct': item.D1PriceChangePct,
                  'D1VolChange': item.D1VolChange,
                  'D1VolChangeOct': item.D1VolChangeOct,
                  'D30Volume': item.D30Volume,
                  'D30PriceChange': item.D30PriceChange,
                  'D30PriceChangePct': item.D30PriceChangePct,
                  'D30VolChange': item.D30VolChange,
                  'D30VolChangePct': item.D30VolChangePct
                },
            changeListener),
        _coinBigDataDeletionAdapter = DeletionAdapter(
            database,
            'CoinBigData',
            ['id'],
            (CoinBigData item) => <String, Object?>{
                  'id': item.id,
                  'symbol': item.symbol,
                  'name': item.name,
                  'logoUrl': item.logoUrl,
                  'status': item.status,
                  'price': item.price,
                  'timestamp': item.timestamp,
                  'circulatingSupply': item.circulatingSupply,
                  'maxSupply': item.maxSupply,
                  'rank': item.rank,
                  'high': item.high,
                  'highTimestamp': item.highTimestamp,
                  'D1Volume': item.D1Volume,
                  'D1PriceChange': item.D1PriceChange,
                  'D1PriceChangePct': item.D1PriceChangePct,
                  'D1VolChange': item.D1VolChange,
                  'D1VolChangeOct': item.D1VolChangeOct,
                  'D30Volume': item.D30Volume,
                  'D30PriceChange': item.D30PriceChange,
                  'D30PriceChangePct': item.D30PriceChangePct,
                  'D30VolChange': item.D30VolChange,
                  'D30VolChangePct': item.D30VolChangePct
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CoinBigData> _coinBigDataInsertionAdapter;

  final DeletionAdapter<CoinBigData> _coinBigDataDeletionAdapter;

  @override
  Stream<List<CoinBigData>> getAllCoins() {
    return _queryAdapter.queryListStream('SELECT * FROM CoinBigData',
        mapper: (Map<String, Object?> row) => CoinBigData(
            id: row['id'] as int?,
            symbol: row['symbol'] as String,
            name: row['name'] as String,
            logoUrl: row['logoUrl'] as String,
            status: row['status'] as String,
            price: row['price'] as String,
            timestamp: row['timestamp'] as String,
            circulatingSupply: row['circulatingSupply'] as String,
            maxSupply: row['maxSupply'] as String,
            rank: row['rank'] as String,
            high: row['high'] as String,
            highTimestamp: row['highTimestamp'] as String,
            D1Volume: row['D1Volume'] as String,
            D1PriceChange: row['D1PriceChange'] as String,
            D1PriceChangePct: row['D1PriceChangePct'] as String,
            D1VolChange: row['D1VolChange'] as String,
            D1VolChangeOct: row['D1VolChangeOct'] as String,
            D30Volume: row['D30Volume'] as String,
            D30PriceChange: row['D30PriceChange'] as String,
            D30PriceChangePct: row['D30PriceChangePct'] as String,
            D30VolChange: row['D30VolChange'] as String,
            D30VolChangePct: row['D30VolChangePct'] as String),
        queryableName: 'CoinBigData',
        isView: false);
  }

  @override
  Stream<CoinBigData?> getCoinDataBySymbol(String symbol) {
    return _queryAdapter.queryStream(
        'SELECT * FROM CoinBigData WHERE symbol = ?1',
        mapper: (Map<String, Object?> row) => CoinBigData(
            id: row['id'] as int?,
            symbol: row['symbol'] as String,
            name: row['name'] as String,
            logoUrl: row['logoUrl'] as String,
            status: row['status'] as String,
            price: row['price'] as String,
            timestamp: row['timestamp'] as String,
            circulatingSupply: row['circulatingSupply'] as String,
            maxSupply: row['maxSupply'] as String,
            rank: row['rank'] as String,
            high: row['high'] as String,
            highTimestamp: row['highTimestamp'] as String,
            D1Volume: row['D1Volume'] as String,
            D1PriceChange: row['D1PriceChange'] as String,
            D1PriceChangePct: row['D1PriceChangePct'] as String,
            D1VolChange: row['D1VolChange'] as String,
            D1VolChangeOct: row['D1VolChangeOct'] as String,
            D30Volume: row['D30Volume'] as String,
            D30PriceChange: row['D30PriceChange'] as String,
            D30PriceChangePct: row['D30PriceChangePct'] as String,
            D30VolChange: row['D30VolChange'] as String,
            D30VolChangePct: row['D30VolChangePct'] as String),
        arguments: [symbol],
        queryableName: 'CoinBigData',
        isView: false);
  }

  @override
  Future<List<CoinBigData?>> getCoinsInFavoritesList(
      List<String> symList) async {
    const offset = 1;
    final _sqliteVariablesForSymList =
        Iterable<String>.generate(symList.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'SELECT * FROM CoinBigData WHERE symbol IN (' +
            _sqliteVariablesForSymList +
            ')',
        mapper: (Map<String, Object?> row) => CoinBigData(
            id: row['id'] as int?,
            symbol: row['symbol'] as String,
            name: row['name'] as String,
            logoUrl: row['logoUrl'] as String,
            status: row['status'] as String,
            price: row['price'] as String,
            timestamp: row['timestamp'] as String,
            circulatingSupply: row['circulatingSupply'] as String,
            maxSupply: row['maxSupply'] as String,
            rank: row['rank'] as String,
            high: row['high'] as String,
            highTimestamp: row['highTimestamp'] as String,
            D1Volume: row['D1Volume'] as String,
            D1PriceChange: row['D1PriceChange'] as String,
            D1PriceChangePct: row['D1PriceChangePct'] as String,
            D1VolChange: row['D1VolChange'] as String,
            D1VolChangeOct: row['D1VolChangeOct'] as String,
            D30Volume: row['D30Volume'] as String,
            D30PriceChange: row['D30PriceChange'] as String,
            D30PriceChangePct: row['D30PriceChangePct'] as String,
            D30VolChange: row['D30VolChange'] as String,
            D30VolChangePct: row['D30VolChangePct'] as String),
        arguments: [...symList]);
  }

  @override
  Future<void> deleteAllCoins() async {
    await _queryAdapter.queryNoReturn('DELETE FROM CoinBigData');
  }

  @override
  Future<void> deleteCoinBySymbol(String symbol) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM CoinBigData WHERE symbol = ?1',
        arguments: [symbol]);
  }

  @override
  Future<void> insertCoin(CoinBigData coinBigData) async {
    await _coinBigDataInsertionAdapter.insert(
        coinBigData, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCoin(CoinBigData coinBigData) async {
    await _coinBigDataDeletionAdapter.delete(coinBigData);
  }
}
