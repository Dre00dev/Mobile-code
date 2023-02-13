//decide if you want the bottom nav bar everywhere or just in topics and about or what.
//using font awesome symbols for the bottom nav bar try and decide which to use later
//import 'package:curved_navigation_bar/curved_navigation_bar.dart'; --fail
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobilecode/theme.dart';
/*
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar( 
      backgroundColor: AppColors.darkModeBackground,
      color: AppColors.secondaryAccent,
      animationDuration: Duration(milliseconds: 300),
      items: [
        
        Icon(
          Icons.home,
          color: Colors.white,
          ),
        Icon(
          Icons.favorite,
          color: Colors.white,
          ),
        Icon(
          Icons.verified_user,
          color:Colors.white,
          ),
        

      ],
      
    );
  }
}
*/

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.secondaryAccent,
      items: const [  //put a constant here 
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.school,
            size: 20,
            ),
          label: 'Topics',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.boltLightning,
            size: 20,
            ),
          label: 'About',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.circleUser,
            size: 20,
            ),
          label: 'Profile',
        )
      ],
      fixedColor: AppColors.darkModeBackground,   // gotta fix this idk what im doing
      onTap: (int index){
        switch(index){  //first icon does nothing
          case 0:    //profile or WIP
          Navigator.pushNamed(context, '/topics');  //this was added by me trying to setup all screens
          break;  //dont do anything yet will add topics screen when db is setup.  WIPWIWPWP  
          case 1:
          Navigator.pushNamed(context, '/about');  //about page route
          break;
          case 2:
          Navigator.pushNamed(context, '/profile');  //profile page route
          break;
        }
      },
      );

  }
}
