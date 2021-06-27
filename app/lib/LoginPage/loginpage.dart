import 'package:app/GoogleSignIn/google_sign.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      child: ElevatedButton(
        onPressed: (){
          final provider = Provider.of<GoogleSignInProvider>(
              context,
              listen: false);
          provider.googleLogin();
        },
        child: Text("Login With Google"),
      ),
    ));;
  }
}

