import 'package:flutter/material.dart';
import 'package:mobilecode/shared/bottom_nav.dart';
import 'package:mobilecode/services/models.dart';
import 'package:mobilecode/shared/loading.dart';
import 'package:mobilecode/shared/error.dart';
import 'package:mobilecode/theme.dart';
import 'package:mobilecode/services/firestore.dart';
import 'package:mobilecode/topics/TopicItem.dart';  
import 'package:mobilecode/topics/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {  //renders differently based on the state of the future  --context,snapshot
        if(snapshot.connectionState == ConnectionState.waiting){
          return const LoadingScreen();
        }
        else if(snapshot.hasError){
          return const ErrorScreen();
        }
        else if(snapshot.hasData){
          var topics = snapshot.data!;  //! because we know its got data and just to be sure

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.secondaryAccent,
              title: Center(
                child: const Text(
                  'Topics',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),  //can wrapped w/ center 
              actions: <Widget> [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/profile'),  //yo im elite
                    child: Icon(
                      FontAwesomeIcons.circleUser,
                      ),
                  ),
                )
              ],
            ),
            drawer:TopicDrawer(topics:topics),  //drawer.dart
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0), 
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topics.map((topic) => TopicItem(topic:topic,)).toList()//Text(topic.title)).toList(),  --will replace Text with a TopicItem in shared
              //TopicItem is the card widget- hero
            ),

            bottomNavigationBar: const BottomNavBar(),
          );
        }

        else{
          return const Text('No Topics found in Firestore :(');
        }

      },
      );
    
  }
}