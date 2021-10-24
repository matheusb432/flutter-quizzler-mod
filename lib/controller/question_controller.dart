import 'package:flutter/cupertino.dart';
import 'package:quizzler_flutter/configs/default_questions.dart';
import 'package:quizzler_flutter/model/question.dart';

class QuestionController extends ChangeNotifier {
  List<Question> questions = [];
  Question? currentQuestion;
  int _questionIndex = 0;

  QuestionController({List<Question>? questions, int? questionIndex}) {
    this.questions = questions ?? DefaultQuestions.getDefaultQuestions();

    currentQuestion = this.questions[questionIndex ?? 0];
  }

  addQuestion(Question question) {
    questions.add(question);

    notifyListeners();
  }

  nextQuestion() {
    _questionIndex++;

    currentQuestion = questions[_questionIndex];

    notifyListeners();
  }

  bool isAnswerCorrect(bool questionAnswer) =>
      currentQuestion?.answer == questionAnswer;

  bool isLastQuestion() => _questionIndex >= questions.length - 1;

  resetQuestions() {
    questions = DefaultQuestions.getDefaultQuestions();

    _questionIndex = 0;

    currentQuestion = questions[0];
  }
}
