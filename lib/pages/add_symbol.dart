import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:layout/network/api_service.dart';
import 'package:layout/model/symbol.dart';
import 'package:layout/database/symbol_dao.dart';
import 'package:logger/logger.dart';

class AddSymbolPage extends StatefulWidget {
  const AddSymbolPage({Key? key}) : super(key: key);

  @override
  _AddSymbolPageState createState() => _AddSymbolPageState();
}

class _AddSymbolPageState extends State<AddSymbolPage> {
  var log = Logger();
  var apiService = APiService();

  TextEditingController searchController = TextEditingController();
  List data = [];
  String name = '';
  String price = '';
  final SymbolDao symbolDao = Get.find();

  Future searchCoinBySymbol(String symbol) async {
    data = await apiService.getCoinBySymbol(symbol);
    setState(() {
      name = data[0]['name'];
      price = data[0]['price'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Symbol to List'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
            child: TextFormField(
              controller: searchController,
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Enter Symbol',
                  suffixIcon: GestureDetector(
                      onTap: () {
                        searchCoinBySymbol(searchController.text);
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        //searchController.text = '';
                      },
                      child: const Icon(Icons.search))),
            ),
          ),
          Text('Crypto: $name'),
          Text('Price: \$$price'),
          MaterialButton(
            onPressed: () async {
              /*final database = await $FloorAppDatabase
                .databaseBuilder('my_database.db')
                .build();
            final symbolDao = database.symbolDao;*/
              var newSymbol = Symbol(symbol: searchController.text);
              symbolDao.insertSymbol(newSymbol);
              searchController.text = '';
            },
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text('Add to List'),
          )
        ],
      ),
    );
  }
}
