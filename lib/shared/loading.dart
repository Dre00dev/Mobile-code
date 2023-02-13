import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//This is a default 
class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/dot.json",
            width: 250,
            height: 250,
            ),
        ],
      ),
    );
  }
}

//create a loading screen with Loader in the middle 
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Loader(),
      );
  }
}

