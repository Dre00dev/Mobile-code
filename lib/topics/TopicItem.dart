import 'package:flutter/material.dart';
import 'package:mobilecode/services/models.dart';
import 'package:mobilecode/shared/progress_bar.dart';
import 'package:mobilecode/theme.dart';
import 'package:mobilecode/topics/drawer.dart';
import 'package:provider/provider.dart';


//consider adding something to the blank space in the card.  maybe some sort of progress indicator?
//it could also have some funny quote or animation but that might be too extra



class TopicItem extends StatelessWidget {

  final Topic topic;  //from models.dart
  const TopicItem({super.key,required this.topic});  //made topic required 

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topic.img,
      child: Card(
        color: AppColors.headerTextColor,
        clipBehavior:Clip.antiAlias,  //makes covers rounded.  
        child: InkWell(   //lets me tap and also has the ink splash animation
          onTap: (){ Navigator.of(context).push(
            MaterialPageRoute(  
              builder: (BuildContext context) => TopicScreen(topic: topic),  //pass the topicsScreen a topic string
            ),
          );
        }, //ontap 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: SizedBox( 
                child: Image.asset('assets/covers/${topic.img}',
                fit: BoxFit.contain,
                ),  //find the image
                
              ),
              ),
            Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    topic.title,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
            Flexible(
              child: TopicProgress(topic: topic,))
            ]//children
          )
        ),
        ),
      
      );
      
  }
}

class TopicScreen extends StatelessWidget {   //note to self move to its own file
  final Topic topic;

  const TopicScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerTextColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryAccent,
      ),
      body: ListView(children: [
        Hero(
          tag: topic.img,
          child: Image.asset('assets/covers/${topic.img}',
              width: MediaQuery.of(context).size.width),//this makes it so it will change sizing if you flip
              //this is cool -- https://api.flutter.dev/flutter/widgets/MediaQuery-class.html
        ),
        Text(
          topic.title,
          style:
              const TextStyle(
                height: 2, 
                fontSize: 20, 
                fontWeight: FontWeight.bold
              ),
        ),
        QuizList(topic: topic)
      ]),
    );
  }
}