import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:mobilecode/quiz/quiz_state.dart';//change notifer
import 'package:mobilecode/services/firestore.dart';  
import 'package:mobilecode/services/models.dart';
import 'package:mobilecode/shared/loading.dart';
import 'package:mobilecode/shared/progress_bar.dart';
import 'package:mobilecode/theme.dart';


//can either create a stateful widget and use setstate to track options, value for progress bar, update user report,
//this works but is not reccomended by flutter docs.  

//will use provider to manage the state. 
//provider is recommended because you are able to seperate the logic from the UI.
//ChangeNotifierProvider lets you create a function that instantiates the class QuizState.


class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key, required this.quizId}) : super(key: key);
  final String quizId;  //passed arg

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder<Quiz>(  //
        future: FirestoreService().getQuiz(quizId),  //grabs quiz based on the quizid 
        builder: (context, snapshot) {
          var state = Provider.of<QuizState>(context);  //access quizstate with build context named state so its quick to access.

          if (!snapshot.hasData || snapshot.hasError){  //dummy forgot the ! :(
            return LoadingScreen();
          }
          else {
            var quiz = snapshot.data!;  //non null assertion op

            //quiz UI
            return Scaffold(
              appBar: AppBar(
                title: AnimatedProgressbar(value: state.progress),  //takes the value of progress in quizstate
                leading: IconButton(  //back button but with a nicer x icon.  
                  icon: const Icon(FontAwesomeIcons.xmark),
                  onPressed: () => Navigator.pop(context),  
                ),
              ),
              body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: state.controller,
        onPageChanged: (int idx) =>
            state.progress = (idx / (quiz.questions.length + 1)),
          itemBuilder: (BuildContext context, int idx) {
            if(idx == 0){
              return StartPage(quiz: quiz);
            }
            else if(idx == quiz.questions.length +1) { //if index is equal to the length of the questions array +1 it will be true
              return CongratsPage(quiz: quiz);
            }
            else{
              return QuestionPage(question: quiz.questions[idx - 1]);  //red lines are due to not declaring question quiz in the widgets
              
            }
          },
        
              
            ),
            );
          }
        }
        
        ),
    );
    
  }
}

//to be implemented one day in the near future

class StartPage extends StatelessWidget {
  final Quiz quiz;

  const StartPage({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(quiz.title,
          style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
          ),
          ),
          const Divider(),   //or spacer??
          Expanded(
            child: Text(quiz.description),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: state.nextPage,
                icon: const Text('Start Quiz!'), 
                label: const Icon(Icons.poll),
                ),
            ],
          )


        ],
      ),
    );
  }
}

class CongratsPage extends StatelessWidget {
  final Quiz quiz;
  const CongratsPage({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Congrats! You completed the ${quiz.title} quiz!',
          textAlign: TextAlign.center,
        ),
        const Divider(),
        //add gif here??
        //const Divider(),
        ElevatedButton.icon(
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,  //for now
          ),
          icon: const Icon(FontAwesomeIcons.check), 
          label: const Text('Mark Complete!'),
          onPressed: (){  //when pressed it
            FirestoreService().updateUserReport(quiz);  //updates user report
            Navigator.pushNamedAndRemoveUntil(
            context, //removes all up to topics screen --done this way so you can pop and go back to quiz
            '/topics',   //routes.dart
            (route) => false);
          }, 
          ),



        
      ],
    );
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;
  const QuestionPage({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(   //holds the question
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(question.text),  //question
          )
        ),
        Container(   //contains the options
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map(   //maps the question options
              (opt){
                return Container(
                  height: 90,
                  margin: const EdgeInsets.only(bottom: 10),
                  color: AppColors.headerTextColor,  //dark card prior
                  child: InkWell(
                    onTap: () {
                    state.selected = opt;
                    _bottomSheet(context, opt, state);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                            state.selected == opt
                                ? FontAwesomeIcons.circleCheck
                                : FontAwesomeIcons.circle,
                            size: 30
                            ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Text(
                              opt.value,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          ).toList(),
        )
        )
      ],
    );
  }
}


/// Bottom sheet shown when Question is answered
  _bottomSheet(BuildContext context, Option opt, QuizState state) {
    bool correct = opt.correct;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: AppColors.headerTextColor,
          height: 250,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(correct ? 'Good Job!' : 'Wrong'),
              Text(
                opt.detail,
                style: const TextStyle(fontSize: 18, color: Colors.white54),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: correct ? Colors.green : Colors.red),
                child: Text(
                  correct ? 'Next!' : 'Try Again',
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (correct) {
                    state.nextPage();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }