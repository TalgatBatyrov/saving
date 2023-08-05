import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ds', () {
    test(
      'Check',
      () {
        const result = 1 + 1;

        expect(result, 2);
      },
    );
    test('Hello', () {
      expect('Hello', 'Hello');
    });
    test('Very goog', () {
      const result = 1 + 2;
      expect(result, 3);
    });
    test('Get bla', () {
      const result = 1 + 3;
      expect(result, 4);
    });
    test('Impact', () {
      const result = 1 + 4;
      expect(result, 5);
    });
  });
}
