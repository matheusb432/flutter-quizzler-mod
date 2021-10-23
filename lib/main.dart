import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quizzler_flutter/view/quiz_page.dart';

import 'controller/answer_controller.dart';
import 'controller/question_controller.dart';

void main() {
  GetIt.I.registerSingleton<AnswerController>(AnswerController());
  GetIt.I.registerSingleton<QuestionController>(QuestionController());

  runApp(const QuizzlerApp());
}
