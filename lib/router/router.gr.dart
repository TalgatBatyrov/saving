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
    SavingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SavingsPage(),
      );
    },
    SavingRoute.name: (routeData) {
      final args = routeData.argsAs<SavingRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SavingPage(
          key: args.key,
          saving: args.saving,
          savingCubit: args.savingCubit,
        ),
      );
    },
  };
}

/// generated route for
/// [SavingsPage]
class SavingsRoute extends PageRouteInfo<void> {
  const SavingsRoute({List<PageRouteInfo>? children})
      : super(
          SavingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SavingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SavingPage]
class SavingRoute extends PageRouteInfo<SavingRouteArgs> {
  SavingRoute({
    Key? key,
    required Saving saving,
    required SavingCubit savingCubit,
    List<PageRouteInfo>? children,
  }) : super(
          SavingRoute.name,
          args: SavingRouteArgs(
            key: key,
            saving: saving,
            savingCubit: savingCubit,
          ),
          initialChildren: children,
        );

  static const String name = 'SavingRoute';

  static const PageInfo<SavingRouteArgs> page = PageInfo<SavingRouteArgs>(name);
}

class SavingRouteArgs {
  const SavingRouteArgs({
    this.key,
    required this.saving,
    required this.savingCubit,
  });

  final Key? key;

  final Saving saving;

  final SavingCubit savingCubit;

  @override
  String toString() {
    return 'SavingRouteArgs{key: $key, saving: $saving, savingCubit: $savingCubit}';
  }
}
