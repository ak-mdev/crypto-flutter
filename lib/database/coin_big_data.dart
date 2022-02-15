import 'package:floor/floor.dart';

@entity
class CoinBigData {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  String symbol;
  String name;
  String logoUrl;
  String status;
  String price;
  String timestamp;
  String circulatingSupply;
  String maxSupply;
  String rank;
  String high;
  String highTimestamp;
  String D1Volume;
  String D1PriceChange;
  String D1PriceChangePct;
  String D1VolChange;
  String D1VolChangeOct;
  String D7Volume;
  String D7PriceChange;
  String D7PriceChangePct;
  String D7VolChange;
  String D7VolChangeOct;
  String D30Volume;
  String D30PriceChange;
  String D30PriceChangePct;
  String D30VolChange;
  String D30VolChangePct;
  String D365Volume;
  String D365PriceChange;
  String D365PriceChangePct;
  String D365VolChange;
  String D365VolChangePct;

  CoinBigData(
      {this.id,
      required this.symbol,
      required this.name,
      required this.logoUrl,
      required this.status,
      required this.price,
      required this.timestamp,
      required this.circulatingSupply,
      required this.maxSupply,
      required this.rank,
      required this.high,
      required this.highTimestamp,
      required this.D1Volume,
      required this.D1PriceChange,
      required this.D1PriceChangePct,
      required this.D1VolChange,
      required this.D1VolChangeOct,
      required this.D7Volume,
      required this.D7PriceChange,
      required this.D7PriceChangePct,
      required this.D7VolChange,
      required this.D7VolChangeOct,
      required this.D30Volume,
      required this.D30PriceChange,
      required this.D30PriceChangePct,
      required this.D30VolChange,
      required this.D30VolChangePct,
      required this.D365Volume,
      required this.D365PriceChange,
      required this.D365PriceChangePct,
      required this.D365VolChange,
      required this.D365VolChangePct});
}
