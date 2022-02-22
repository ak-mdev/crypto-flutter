import 'package:flutter/material.dart';
import 'package:layout/auth/google_sign_in_provider.dart';
import 'package:provider/provider.dart';


class LoginPagePage extends StatelessWidget {
  const LoginPagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Padding(
           padding: const EdgeInsets.all(32.0),
           child: MaterialButton(onPressed: () {
             final provider =
             Provider.of<GoogleSignInProvider>(context, listen: false);
             provider.googleLogIn();
           },
           child: const Center(child: Text('Sign In')),
           color: Colors.blueGrey,
           textColor: Colors.white,
           ),
         )
       ],
     ),

    );
  }
}