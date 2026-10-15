import 'package:flutter_test/flutter_test.dart';

import 'package:skill_swap/main.dart';

void main() {
  testWidgets('App opens without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const SkillSwapApp());
  });
}