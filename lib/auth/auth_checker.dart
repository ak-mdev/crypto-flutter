import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:layout/auth/login_page.dart';
import 'package:layout/pages/crypto_list.dart';
import 'package:layout/utils/util.dart';

//import 'package:layout/ui/home_page.dart';
//import 'package:layout/ui/login_page.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const CryptoListPage();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else {
            return const LoginPagePage();
          }
        },
      ),
    );
  }
}
