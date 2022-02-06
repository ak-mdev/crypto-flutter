import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class ListProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<String> _symList = [];
  final box = GetStorage();

  List<String> get symList => _symList;

  getSymList() {
    _symList = box.read('sym_list');
    notifyListeners();
  }

  setSymList(List myList) {
    _symList = myList.cast<String>();
    notifyListeners();
  }

  deleteFromSymList(List myList, String deleteName) {
    myList.remove(deleteName);
    _symList = myList.cast<String>();
    box.write('sym_list', _symList);
    notifyListeners();
  }

  void addToList(String symbol) {
    _symList.add(symbol);
    box.write('sym_list', _symList);
    notifyListeners();
  }


}