//this file is for working with firestore with dart classes

// firestore returns a map --keys are strings --values are dynamic or whatever gets returned

//better/easier practice is using classes which is possible with json_serializable --see pubspec.yaml


//define classes for every map you need and match the fields for that map.
//then make a constructor to make a default value for each of these properties
// Adding these values will give me less errors, null safety, and would be easier idk json and dont feel like learning it rn 


import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';  //This creates the file with generated code

@JsonSerializable()  //idk but docs say to put this here before class declarations
class Option {
  String value;
  String detail;
  bool correct;
  Option({     //constructor to give default value to everything and make sure it isn't null
    this.value = '',
    this.detail = '', 
    this.correct = false
    });
  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);     //documentation copied and pasted and changed class names 
  Map<String, dynamic> toJson() => _$OptionToJson(this);                            //documentation copied and pasted and changed class names
}

@JsonSerializable()
class Question {
  String text;
  List<Option> options;
  Question({
    this.options = const [], 
    this.text = ''
  });
  factory Question.fromJson(Map<String, dynamic> json) =>_$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Quiz {
  String id;
  String title;
  String description;
  String video;
  String topic;
  List<Question> questions;

  Quiz({
      this.title = '',
      this.video = '',
      this.description = '',
      this.id = '',
      this.topic = '',
      this.questions = const []
      });
  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}

@JsonSerializable()
class Topic {
  late final String id;
  final String title;
  final String description;
  final String img;
  final List<Quiz> quizzes;

  Topic(
      {this.id = '',
      this.title = '',
      this.description = '',
      this.img = 'default.png',
      this.quizzes = const []
      });

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

@JsonSerializable()
class Report {
  String uid;
  int total;
  Map topics;

  Report({
    this.uid = '', 
    this.topics = const {}, 
    this.total = 0
    });
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);
}