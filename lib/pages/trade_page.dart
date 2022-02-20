import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:layout/auth/auth_checker.dart';
import 'package:layout/utils/util.dart';

class TradePage extends StatefulWidget {
  const TradePage({Key? key}) : super(key: key);


  @override
  _TradePageState createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
 // final user = FirebaseAuth.instance.currentUser!;
  var util = Utils();
  bool isLoggedIn = false;



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade Game'),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}