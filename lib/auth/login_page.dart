

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'google_sign_in_provider.dart';


class LoginPagePage extends StatelessWidget {
  const LoginPagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignIn'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            /*child: Image.asset(
              'images/flutterimg.png',
              width: 400,
              height: 300,
            ),*/
            child: Center(
              child: SvgPicture.asset(
                'images/trilevel.svg',
                semanticsLabel: 'Michael',
                width: 400,
                height: 300,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: MaterialButton(
              onPressed: () {
                final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogIn();
              },
              child: const Text('Sign in with Google'),
              color: Colors.red,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
          )
        ],
      ),
    );
  }
}