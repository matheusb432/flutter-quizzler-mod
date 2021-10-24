import 'package:quizzler_flutter/model/question.dart';

class DefaultQuestions {
  static List<Question> getDefaultQuestions() => [
        Question(
          '7 % 2 == 0.',
          false,
        ),
        Question(
          'The reason dependency injection is used is primarily to reduce coupling and make a class independent of it\'s dependencies',
          true,
        ),
        Question(
          'In JavaScript, [5, 2, 4].map(x => x + 1) is exactly [6, 3, 5]',
          true,
        ),
        Question(
          'In JavaScript, [12, 7, 20].map(x => x - x) is exactly [0, 0 ,0]',
          true,
        ),
        Question(
          'In C#, [20, 5, 1].Except([5, 1]) is exactly [5, 1]',
          false,
        ),
        Question(
          'In Dart, [2, 5, 10].fold(0, (p, e) => p + e) is equal to 17',
          true,
        ),
        Question(
          'In Dart, Random().nextInt(5) gets a random number between 0 and 5',
          false,
        ),
        Question(
          'In Angular, @Input() is necessary when binding any data to an HTML input',
          false,
        ),
        Question(
          'In React, using the hook useEffect() like useEffect(() => {}, []) will make the callback execute only once when the component is built',
          true,
        ),
        Question(
          'In React, using the hook useEffect() like useEffect(() => {}) will make the callback execute infinitely',
          true,
        ),
      ];
}
