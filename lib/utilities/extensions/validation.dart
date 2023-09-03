extension EmailValidation on String {
  bool get isValidEmail {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    return length >= 6;
  }
}
