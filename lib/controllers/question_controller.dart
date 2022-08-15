import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:sustomer_flutter_task/models/Questions.dart';
import 'package:sustomer_flutter_task/models/question_model.dart';
import 'package:sustomer_flutter_task/screens/score/score_screen.dart';
import 'package:sustomer_flutter_task/services/firestore_services.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  AnimationController? _animationController;
  Animation? _animation;

  // so that we can access our animation outside
  Animation get animation => this._animation!;
  FirestoreService? _firestoreService;

  PageController? _pageController;

  PageController get pageController => this._pageController!;
  RxBool loading = false.obs;

  List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();

  List<Question> get questions => this._questions;

  bool _isAnswered = false;

  bool get isAnswered => this._isAnswered;
  bool _isNextTap = false;

  bool get isNextTap => this._isNextTap;

  set setNextTap(bool isTap) {
    this._isNextTap = isTap;
    update();
  }

  int _correctAns = 0;

  int get correctAns => this._correctAns;

  int _selectedAns = 0;

  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;

  int get numOfCorrectAns => this._numOfCorrectAns;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    _firestoreService = FirestoreService();
    getAllQ();
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController!.forward().whenComplete(nextQuestion);
    _pageController = PageController();

    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController!.dispose();
    _pageController!.dispose();
  }

  // Stream<List<Client>> get clientstream => firestoreService.getclientstream();
  List<QuestionModel>? questionList;
  List<QuestionM>? allQuestions;

  Future<List<QuestionM>> get allQ => _firestoreService!.getQuestions();

  Future<void> getAllQuestions() async {
    questionList = await _firestoreService!.retrieveQuestions();
  }

  Future<void> getAllQ() async {
    allQuestions = await _firestoreService!.getQuestions();
  }

  void checkAns(QuestionM question, int selectedIndex) {
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.correctAnswerIndex!;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    // It will stop the counter
    // _animationController!.stop();
    // _animationController!.reset();
    update();
    setNextTap=false;
    // Once user select an ans after 3s it will go to the next qn
    // Future.delayed(Duration(seconds: _animationController!.duration!.inSeconds),
    //     () {
    //   _isNextTap = false;
    //   nextQuestion();
    // });
  }

  void nextQuestion() {
    if (_questionNumber.value != allQuestions!.length) {
      _isAnswered = false;
      _pageController!
          .nextPage(duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController!.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController!.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to naviigate another page
      Get.to(ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
