import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mobilecode/services/auth.dart';
import 'package:mobilecode/services/models.dart';

class FirestoreService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;   //makes it so i dont gotta type FirebaseFirestore.instance everytime


  //read documents from topics collection
  Future<List<Topic>> getTopics() async{  //gettopics method will return a future list of topics
    var ref = _db.collection('topics');  //this a reference to the topics collection
    var snapshot = await ref.get();  //get returns the topics screen once not in realtime.  
    //same as writing var snapshot = await FirebaseFirestore.instance.collection('topics').get()
    //Previously ugly and these naming conventions are used by others.
    //=> arrow syntax shorthand for {return expression;} 
    var data = snapshot.docs.map((s) => s.data());  //turns snapshot into data as a dart map
    var topics = data.map((d) => Topic.fromJson(d));  //this turns the dart map into a list called topics with the fromJson constructor
    //from Jsonconstructor was created by jsonserializable or models.dart,models.g.dart
    return topics.toList();
  }

  //Fetches a single quiz document  -- no collection
  Future<Quiz> getQuiz(String quizId) async{  //takes quizId as an argument and returns that quiz. 
    var ref = _db.collection('quizzes').doc(quizId);  //reference to the quiz that is passed.
    var snapshot = await ref.get();  //returns the quiz doc in a map form --which we don't want 
    return Quiz.fromJson(snapshot.data() ?? {});  //this converts it into a quiz model using fromJson constructor.
    //if snapshot.data is null it will pass an empty map so no null errors.  
  }

  //Realtime Stream of User Report or scores document
  Stream<Report> streamReport() {  
    return AuthService().userStream.switchMap((user) {
      //return FirebaseAuth.instance.authStateChanges().switchMap((FirebaseAuth.instance.currentUser)  -- same energy we just made it shorter in auth.dart
      if (user != null) {         //null safety on everything
        var ref = _db.collection('reports').doc(user.uid);  //get the document in the reports collection with the matching username
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!)); //returns snapshot which is converted into report via fromJson constructor.
        //the assertion operator or "!" is required to make sure it isn't null or undefined.  -- this is why error 10/27/22 occurred 
        //the compiler was acting up -- :/
      } 
      else {
        return Stream.fromIterable([Report()]);
        //this returns default report when you are not logged in and it switches when they logout to default
      }
    });
  }
  Future<void> updateUserReport(Quiz quiz){  //this is based on the event of quiz completion so not async or stream
    var user = AuthService().user!;  //can only be used if user is logged in -- authService.user should be null therefore using assertion operator in case
    var ref = _db.collection('reports').doc(user.uid);

    //----- map with strings as key and dynamic types as values ---
    var data = {
      'total':FieldValue.increment(1),  //sets count +1
      'topics':{  //adds a topic map 
        quiz.topic: FieldValue.arrayUnion([quiz.id])  //merges values into list
      }
    };

    //writes to the data base with ref set  -- passing data and merge true
    return ref.set(data, SetOptions(merge: true));
    //we set it as merge true because it will be nondestructive and won't override data if there is any data.  
  }

}