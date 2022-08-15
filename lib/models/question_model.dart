import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
   String ?question;
   List<String> ?answers;
   int ?correctAnswerIndex;

  QuestionModel({required this.question,required this.answers,required this.correctAnswerIndex});
  QuestionModel.fromJson( DocumentSnapshot<Map<String, dynamic>> json){
    question = json['question'];
    if(json['answers']!=null){
      //List.from(value.data['point'])
      // answers = json['answer'].map<String>((e)=>e).toList();
      answers = List.from(json['answers']);
    }
    correctAnswerIndex = json['correctAnswerIndex'];
  }


  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answers,
      'correctAnswerIndex': correctAnswerIndex,
    };
  }
}


class QuestionM {
  String? questionText;
  int ?correctAnswerIndex;
  List<Answers>? answers;

  QuestionM({this.questionText, this.answers,this.correctAnswerIndex});

  QuestionM.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
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
