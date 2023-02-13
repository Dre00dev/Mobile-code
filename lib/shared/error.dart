import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


// ---------Error Screen------------
class ErrorScreen extends StatelessWidget {
  final String message;  //forgot to initialize message 
  const ErrorScreen({super.key, this.message = 'Darn it broke :('});  

  @override
  Widget build(BuildContext context) {
    return Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/no_good.json",
              width: 150,
              height: 150,
              ),
              
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Error While Loading...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
    );
    //will probably put a pretty error image or something funny here but this is simple for now
  }
}
