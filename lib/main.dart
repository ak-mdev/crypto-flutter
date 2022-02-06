import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/pages/crypto_list.dart';
import 'package:layout/pages/favorites_page.dart';
import 'package:layout/database/provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'database/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final database =
      await $FloorAppDatabase.databaseBuilder('my_database.db').build();
  final coinDao = database.coinBigDataDao;
  final favoritesDao = database.favoritesDao;
  Get.put(favoritesDao);
  Get.put(coinDao);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListProvider())
      ],
  child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTitle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  var log = Logger();
  final pages = [const CryptoListPage(), const FavoritesPage()];
  final box = GetStorage();
  List myList = [];


  @override
  void initState() {
    super.initState();
    getFavoritesList();
  }

  Future<void>getFavoritesList() async {
    myList = await box.read('sym_list');
    await context.read<ListProvider>().setSymList(myList);
   // log.i(myList);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Cryptos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Favorite'),
        ],
      ),
    );
  }
}
