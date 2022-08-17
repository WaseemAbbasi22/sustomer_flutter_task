import 'package:cloud_firestore/cloud_firestore.dart';
class Question {
  String? questionText;
  int ?correctAnswerIndex;
  List<Answers>? answers;

  Question({this.questionText, this.answers,this.correctAnswerIndex});

  Question.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    questionText = json['question'];
    correctAnswerIndex=json['correctAnswer'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.questionText;
    data['correctAnswer']=this.correctAnswerIndex;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String? text;
  int? score;

  Answers({this.text, this.score});

  Answers.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    score = json['average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['average'] = this.score;
    return data;
  }
}
