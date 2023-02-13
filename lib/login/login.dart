import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobilecode/services/auth.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset("assets/rocket.json",
              width: 250,
              height: 250,
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Mobile Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Learn Data Structures on your Phone',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            FutureBuilder<Object>(
        future: SignInWithApple.isAvailable(),
        builder: (context, snapshot) {
        if (snapshot.data == true) {
            return SignInWithAppleButton(
            onPressed: () {
                AuthService().signInWithApple();
            },
            );
        } else {
            return Container();
        }
        },
    ),
            Flexible( 
              child: LoginButton(
                text: 'Google Sign In',
                icon: FontAwesomeIcons.google,
                color: Colors.blue,
                loginMethod: AuthService().googleLogin,
                ),
              ),
            Flexible(
              child: LoginButton(  //see below 
                icon: FontAwesomeIcons.userNinja,
                text: 'Login as Guest',
                loginMethod: AuthService().anonLogin,
                color: Colors.lightBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {  // THIS SHOULD WORK FOR ALL THREE sign in options
  final Color color;
  final IconData icon;  
  final String text;
  final Function loginMethod;  //see auth.dart

  const LoginButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.color,
      required this.loginMethod});  //makes sure loginButton has the following properties :)

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(    //Note: icon is default to left but can move
        icon: Icon(
          icon,  
          color: Colors.black87,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),  //shoutout google tutorial 
          backgroundColor: color,
        ),
        onPressed: () => loginMethod(),  //see auth.dart 
        label: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
      