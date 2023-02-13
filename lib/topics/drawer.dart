//app drawer plan

//This will be an app drawer consisting of topics and quiz cards.

//There will a topic.title and then below will be a card widget including quizes 
//the card widget should be reusable for 
//TopicDrawer(topics: topics)  --make topic the argument and make it required


//make the drawer a listview.seperated and then setup a column within within the column after setting up the title
// create QuizList(topic:topic) this will return a column consisting of )
//in the column will be a card widget with all the quizzes corresponding to the topic 
//the cardwill have it properties set then an inkwell inside it will have ontop
//the card will consist of a container with padding inside
//then it will have a ListTile widget within consisting of title, subtitle, and leading check properties

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobilecode/main.dart';
import 'package:mobilecode/services/models.dart';
import 'package:mobilecode/quiz/quiz.dart';  
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobilecode/theme.dart';
import 'package:mobilecode/services/models.dart';

class TopicDrawer extends StatelessWidget {
  final List<Topic> topics;
  const TopicDrawer({ Key? key, required this.topics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.headerTextColor,
      child: ListView.separated(
          shrinkWrap: true,  //set as true so we can use seperators @bottom of card
          itemCount: topics.length,  //length method for length of list
          itemBuilder: (BuildContext context, int idx) {
            Topic topic = topics[idx];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    topic.title,
                    //textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                QuizList(topic: topic)  //takes topic arg
              ],
            );
          },
          separatorBuilder: (BuildContext context, int idx) => const Divider()),
    );
  }
}
// ------maybe put in own file for readability
class QuizList extends StatelessWidget {
  final Topic topic;
  const QuizList({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: topic.quizzes.map(  //map of quizzes 
        (quiz) {
          return Card(
            color: Colors.blue,   //color of quiz title card
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 4,
            margin: const EdgeInsets.all(4),
            child: InkWell(
              onTap: () {  // runs the quiz
                Navigator.of(context).push(
                  MaterialPageRoute(  //creates quiz screen
                    builder: (BuildContext context) => 
                      QuizScreen(quizId: quiz.id),  //pass quiz id to quizscreen 
                    ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    quiz.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryWhiteColor,  //might look for an off white type shit but thats another day
                    ),
                  ),
                  subtitle: Text(
                    quiz.description,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 16,
                      
                      color: AppColors.primaryWhiteColor,
                    ),
                  ),
                  leading: QuizBadge(topic: topic, quizId: quiz.id),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
class QuizBadge extends StatelessWidget {
  final String quizId;
  final Topic topic;

  const QuizBadge({super.key, required this.quizId, required this.topic});

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    List completed = report.topics[topic.id] ?? [];
    if (completed.contains(quizId)) {
      return const Icon(
        FontAwesomeIcons.checkDouble, 
        color: Colors.green);
    } else {
      return const Icon(
        FontAwesomeIcons.solidCircle, 
        color: Colors.grey);
    }
  }
}
