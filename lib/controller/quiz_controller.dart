import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:quizzler_flutter/controller/question_controller.dart';

import 'answer_controller.dart';

class QuizController extends ChangeNotifier {
  bool isQuizActive = true;

  final QuestionController _questionController = GetIt.I<QuestionController>();
  final AnswerController _answerController = GetIt.I<AnswerController>();

  endQuiz() {
    isQuizActive = false;
    int score = _answerController.getScore();
    int totalScore = _answerController.answers.length;

    _questionController.currentQuestion?.statement =
        'Score: $score/$totalScore';

    notifyListeners();
  }

  restartQuiz() {
    _questionController.resetQuestions();

    _answerController.resetAnswers();

    isQuizActive = true;

    notifyListeners();
  }
}
