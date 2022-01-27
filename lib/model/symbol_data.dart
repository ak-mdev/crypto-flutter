import 'package:floor/floor.dart';

@entity
class SymbolData {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  String sym;

  SymbolData({this.id, required this.sym});
}
