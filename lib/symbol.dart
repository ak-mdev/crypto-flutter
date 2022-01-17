import 'package:floor/floor.dart';

@entity
class Symbol {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  String symbol;

  Symbol({this.id, required this.symbol});
}