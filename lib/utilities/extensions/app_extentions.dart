import 'package:saving/utilities/enums/app_enums.dart';

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
