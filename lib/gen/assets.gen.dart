/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsI18nGen {
  const $AssetsI18nGen();

  /// File path: assets/i18n/en.json
  String get en => 'assets/i18n/en.json';

  /// File path: assets/i18n/kr.json
  String get kr => 'assets/i18n/kr.json';

  /// File path: assets/i18n/pl.json
  String get pl => 'assets/i18n/pl.json';

  /// File path: assets/i18n/pr.json
  String get pr => 'assets/i18n/pr.json';

  /// File path: assets/i18n/ru.json
  String get ru => 'assets/i18n/ru.json';

  /// File path: assets/i18n/sp.json
  String get sp => 'assets/i18n/sp.json';

  /// File path: assets/i18n/uk.json
  String get uk => 'assets/i18n/uk.json';

  /// List of all assets
  List<String> get values => [en, kr, pl, pr, ru, sp, uk];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/minus.json
  String get minus => 'assets/lottie/minus.json';

  /// File path: assets/lottie/plus.json
  String get plus => 'assets/lottie/plus.json';

  /// List of all assets
  List<String> get values => [minus, plus];
}

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/add.png
  AssetGenImage get add => const AssetGenImage('assets/png/add.png');

  /// File path: assets/png/add_saving.png
  AssetGenImage get addSaving =>
      const AssetGenImage('assets/png/add_saving.png');

  /// File path: assets/png/icon_app.png
  AssetGenImage get iconApp => const AssetGenImage('assets/png/icon_app.png');

  /// File path: assets/png/saving.png
  AssetGenImage get saving => const AssetGenImage('assets/png/saving.png');

  /// File path: assets/png/statistic.png
  AssetGenImage get statistic =>
      const AssetGenImage('assets/png/statistic.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [add, addSaving, iconApp, saving, statistic];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/bitcoin.svg
  String get bitcoin => 'assets/svg/bitcoin.svg';

  /// List of all assets
  List<String> get values => [bitcoin];
}

class Assets {
  Assets._();

  static const $AssetsI18nGen i18n = $AssetsI18nGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
