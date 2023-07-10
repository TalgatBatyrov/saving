import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import '../features/saving/bloc/saving_cubit.dart';
import '../features/saving/view/savings_page.dart';
import '../features/saving/widgets/saving_page.dart';
import '../repositories/savings/models/saving.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SavingsRoute.page, path: '/'),
        AutoRoute(page: SavingRoute.page),
      ];
}
