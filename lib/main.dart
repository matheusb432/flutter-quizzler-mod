import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzler_flutter/view/quiz_page.dart';

import 'configs/dependency_injections.dart';

void main() {
  DependencyInjectionConfig.addDependencyInjections();

  runApp(const QuizzlerApp());
}
