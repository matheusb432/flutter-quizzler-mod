import 'package:flutter/cupertino.dart';
import 'package:quizzler_flutter/model/answer.dart';

class AnswerController extends ChangeNotifier {
  List<Answer> answers = [];

  addAnswer(Answer answer) {
    answers.add(answer);

    notifyListeners();
  }

  resetAnswers() {
    answers = [];

    notifyListeners();
  }

  getScore() {
    // ? this is kind of like reduce() in JS, essentially just counting all the correct answers though.
    return answers.fold(
        0, (int prev, Answer el) => prev + (el.isCorrect ? 1 : 0));
  }
}
