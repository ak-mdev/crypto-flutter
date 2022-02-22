import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:layout/auth/google_sign_in_provider.dart';
import 'package:layout/database/provider.dart';
import 'package:layout/pages/home.dart';
import 'package:provider/provider.dart';

import '../database/database.dart';
import 'auth/auth_checker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  final database =
      await $FloorAppDatabase.databaseBuilder('my_database.db').build();
  final coinDao = database.coinBigDataDao;
  final favoritesDao = database.favoritesDao;
  Get.put(favoritesDao);
  Get.put(coinDao);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ListProvider()),
      ChangeNotifierProvider(create: (_) => GoogleSignInProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTitle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthChecker(),
    );
  }
}
