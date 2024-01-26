import 'package:saving/core/utils/enums.dart';

extension AppExtensions on ActionButton {
  String get asset {
    switch (this) {
      case ActionButton.add:
        return 'assets/lottie/plus.json';
      case ActionButton.remove:
        return 'assets/lottie/minus.json';
    }
  }
}
