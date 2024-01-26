// first letter to uppercase extensions

extension StringExtension on String {
  String get firstLetterToUpperCase {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
