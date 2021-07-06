import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:do_it/GoogleSignIn/google_sign.dart';
import 'package:do_it/screens/splashscreen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * .5,
            ),
            Container(
              height: screenHeight * .7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FeatherIcons.checkCircle,
                    color: Colors.black,
                    size: 80,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Do - It",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ),
                ],
              ),
            ),
            Container(
              height: screenHeight * .1,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText('Do It'),
                    FadeAnimatedText('Do It RIGHT!'),
                    FadeAnimatedText('Do It RIGHT NOW!'),
                  ],
                ),
              ),
            ),
            Container(
              height: screenHeight * .1,
              child: isPressed
                  ? SplashScreen()
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          isPressed = true;
                        });

                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                      },
                      child: Text(
                        "Login With Google",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
