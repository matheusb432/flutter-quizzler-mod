import 'package:get_it/get_it.dart';
import 'package:quizzler_flutter/controller/answer_controller.dart';
import 'package:quizzler_flutter/controller/question_controller.dart';
import 'package:quizzler_flutter/controller/quiz_controller.dart';

class DependencyInjectionConfig {
  static addDependencyInjections() {
    _addSingletonDIs();
  }

  static _addSingletonDIs() {
    GetIt.I.registerSingleton<AnswerController>(AnswerController());
    GetIt.I.registerSingleton<QuestionController>(QuestionController());
    GetIt.I.registerSingleton<QuizController>(QuizController());
  }
}
