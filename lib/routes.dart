import 'package:flutter/material.dart';

import 'package:mobilecode/about/about.dart';
import 'package:mobilecode/home/home.dart';
import 'package:mobilecode/login/login.dart';
import 'package:mobilecode/profile/profile.dart';
import 'package:mobilecode/topics/topics.dart';

//importing all packages except for quiz screen thats in topics not here

//Note to self you probably gotta do quiz later within topics somewhere worry about it later
//if today is later then hopefully this helps


//keys to map a string value to widget so they will route to these widgets
var appRoutes = {
  '/': (context) => const HomeScreen(),    //root or home screen
  '/login': (context) => const LoginScreen(),  //login route
  '/topics':(context) => const TopicsScreen(), //topic route
  '/home':(context) => const HomeScreen(), //home route
  '/profile':(context) => const ProfileScreen(), //profile route
  '/about':(context) => const AboutScreen(),  //about route
};

//will route quiz after -- i need the firebase database

//ideas or removed screens
//score screen -- basically scores for each quiz
//resources screen -- w3 schools or opensource material to help with the topic (prob youtube links or books)
//create quiz screen -- create your own quiz or study mateiral
//friends screen -- show your freinds or contacts or other people's score
//reminder or push notifications -- to remind people to study on the app or elsewhere at a designated time each day.
