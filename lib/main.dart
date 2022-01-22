import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:layout/database/database.dart';
import 'crypto_list.dart';
import 'crypto_list2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('my_database.db').build();
  final dao = database.symbolDao;
  Get.put(dao);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTitle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CryptoList2Page(),
    );
  }

}

