import 'package:flutter/material.dart';
import 'package:mobilecode/theme.dart';
//import 'package:studyapp/shared/bottom_nav.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:mailto/mailto.dart';

//I really dont know what to put here so an app bar with an animation will be placed here for the time being
//maybe ill change this to a resources screen but i find it simpler to do that in the quiz selection screen. 
//:(
class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryAccent,
        title: const Text('About',
          style: TextStyle(
            fontWeight:FontWeight.bold
            ),
          )
        ),
      body:Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Lottie.asset("assets/rocket.json",
              width: 250,
              height: 250,
              ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Learn Data Structures on your Phone.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
           const Text('By Andres Pulgarin',
            style:TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 14,
             ),
            ),
            /*ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.prettypurple1),
                  ),
                child: const Text('Contact'),
                  onPressed: () => launchUrl(emailLaunchUri)
            ),*/
          ],
       ),
      ),
      
      //bottomNavigationBar: const BottomNavBar(),--if you add these consider making it a material page route for the navbar buttons
    );
    
  }
}

/*_sendEmail(){
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'andrespulgarin00@outlook.com',
    queryParameters: {
      'subject': 'MobileCode Feedback',
      'body': 'Hi Andres,'
    },
    );
  

  launchUrlString(emailLaunchUri.toString().replaceAll('+', ' '));

}*/




