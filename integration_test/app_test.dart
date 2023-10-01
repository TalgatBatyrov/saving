// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:saving/main.dart' as app;

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   testWidgets(
//     'Auth',
//     (widgetTester) async {
//       app.main();
//       await widgetTester.pumpAndSettle();

//       await Future.delayed(const Duration(seconds: 4));

//       //  нужно найти кнопку добавить и нажать на нее

//       await widgetTester.tap(find.byIcon(Icons.add));

//       await widgetTester.pumpAndSettle();

//       await widgetTester.tap(find.byIcon(Icons.add));

//       await widgetTester.pumpAndSettle();

//       await widgetTester.tap(find.byIcon(Icons.add));

//       await widgetTester.pumpAndSettle();

//       // await widgetTester.enterText(
//       //   find.byType(TextFormField).at(0),
//       //   'take@gmail.com',
//       // );

//       // await Future.delayed(const Duration(seconds: 4));

//       await widgetTester.tap(find.byIcon(Icons.add));

//       // await widgetTester.enterText(find.byType(TextFormField), '123456');
//       // await Future.delayed(const Duration(seconds: 4));

//       // await widgetTester.tap(find.byType(ElevatedButton));
//       // await Future.delayed(const Duration(seconds: 4));

//       await widgetTester.pumpAndSettle();

//       expect(find.byType(ListTile), findsNWidgets(2));
//     },
//   );
// }
