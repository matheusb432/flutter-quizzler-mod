import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quizzler_flutter/controller/answer_controller.dart';
import 'package:quizzler_flutter/controller/question_controller.dart';
import 'package:quizzler_flutter/controller/quiz_controller.dart';
import 'package:quizzler_flutter/model/answer.dart';

class QuizzlerApp extends StatelessWidget {
  const QuizzlerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final Color trueColor = Colors.indigo;
  final Color falseColor = Colors.redAccent;
  List<Expanded> answerButtons = [];

  @override
  void initState() {
    super.initState();

    answerButtons.addAll([
      buildAnswerButton(item: 'True', color: trueColor, questionAnswer: true),
      buildAnswerButton(
          item: 'False', color: falseColor, questionAnswer: false),
    ]);
  }

  QuizController quizController = GetIt.I<QuizController>();
  AnswerController answerController = GetIt.I<AnswerController>();
  QuestionController questionController = GetIt.I<QuestionController>();

  Expanded buildAnswerButton(
      {required String item,
      required Color color,
      required bool questionAnswer,
      Function()? onPressedCallback}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: onPressedCallback ?? () => _answerQuestion(questionAnswer),
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: color,
            onPrimary: Colors.white,
          ),
        ),
      ),
    );
  }

  List<Expanded> _defaultAnswerButtons() => [
        buildAnswerButton(item: 'True', color: trueColor, questionAnswer: true),
        buildAnswerButton(
            item: 'False', color: falseColor, questionAnswer: false),
      ];

  Icon buildResultIcon({required bool isCorrect}) {
    IconData? icon;
    Color? color;
    double size = 24;

    if (isCorrect) {
      icon ??= Icons.check;
      color ??= trueColor;
    } else {
      icon ??= Icons.close;
      color ??= falseColor;
    }

    return Icon(
      icon,
      color: color,
      size: size,
    );
  }

  void rebuildAnswerButtons() {
    bool active = quizController.isQuizActive;
    if (active) {
      setState(() {
        answerButtons = _defaultAnswerButtons();
      });
    } else {
      setState(() {
        answerButtons = [
          buildAnswerButton(
            item: 'Restart Quiz',
            color: Colors.green,
            questionAnswer: true,
            onPressedCallback: () {
              quizController.restartQuiz();

              rebuildAnswerButtons();
            },
          )
        ];
      });
    }
  }

  void _answerQuestion(bool questionAnswer) {
    if (!quizController.isQuizActive) {
      return;
    }

    bool result = questionController.isAnswerCorrect(questionAnswer);

    answerController.addAnswer(
      Answer(
        buildResultIcon(isCorrect: result),
        result,
      ),
    );

    if (questionController.isLastQuestion()) {
      quizController.endQuiz();

      rebuildAnswerButtons();
    } else {
      questionController.nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: AnimatedBuilder(
                animation: questionController,
                builder: (_, __) => Text(
                  questionController.currentQuestion?.statement ??
                      'No questions :(',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
        ...answerButtons,
        // ? AnimatedBuilder() with controller animation to update the state
        // ? of scoreKeeper without needing to use setState(), also keeps the
        // ? the same instance of scoreController throughout the app since it`s
        // ? an injected singleton instance.
        AnimatedBuilder(
          animation: answerController,
          builder: (_, __) {
            // ? Wrap() with horizontal axis is basically a row that can
            // ? extend to multiple rows if their elements occupy the entire
            // ? screen space, can be a column to with vertical axis.
            return Wrap(
              direction: Axis.horizontal,
              children: answerController.answers
                  .map((Answer s) => s.answerIcon)
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
