// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    VerifyEmailRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const VerifyEmailScreen(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    SavingsRoute.name: (routeData) {
      final args = routeData.argsAs<SavingsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SavingsPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    StatisticRoute.name: (routeData) {
      final args = routeData.argsAs<StatisticRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StatisticPage(
          key: args.key,
          saving: args.saving,
        ),
      );
    },
  };
}

/// generated route for
/// [VerifyEmailScreen]
class VerifyEmailRoute extends PageRouteInfo<void> {
  const VerifyEmailRoute({List<PageRouteInfo>? children})
      : super(
          VerifyEmailRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifyEmailRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SavingsPage]
class SavingsRoute extends PageRouteInfo<SavingsRouteArgs> {
  SavingsRoute({
    Key? key,
    required AuthUser user,
    List<PageRouteInfo>? children,
  }) : super(
          SavingsRoute.name,
          args: SavingsRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'SavingsRoute';

  static const PageInfo<SavingsRouteArgs> page =
      PageInfo<SavingsRouteArgs>(name);
}

class SavingsRouteArgs {
  const SavingsRouteArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final AuthUser user;

  @override
  String toString() {
    return 'SavingsRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [StatisticPage]
class StatisticRoute extends PageRouteInfo<StatisticRouteArgs> {
  StatisticRoute({
    Key? key,
    required Saving saving,
    List<PageRouteInfo>? children,
  }) : super(
          StatisticRoute.name,
          args: StatisticRouteArgs(
            key: key,
            saving: saving,
          ),
          initialChildren: children,
        );

  static const String name = 'StatisticRoute';

  static const PageInfo<StatisticRouteArgs> page =
      PageInfo<StatisticRouteArgs>(name);
}

class StatisticRouteArgs {
  const StatisticRouteArgs({
    this.key,
    required this.saving,
  });

  final Key? key;

  final Saving saving;

  @override
  String toString() {
    return 'StatisticRouteArgs{key: $key, saving: $saving}';
  }
}
