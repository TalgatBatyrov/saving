import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import '../features/auth/view/splash_screen.dart';
import '../features/auth/view/sign_up_page.dart';
import '../features/auth/view/sing_in_page.dart';
import '../features/saving/view/savings_page.dart';
import '../features/statistic/view/statistic_page.dart';
import '../repositories/savings/models/saving.dart';
import '../repositories/user/models/auth_user.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        // TODO: AutoRoute(page: SplashRoute.page, initial: true),
        // Splash route: isAuth ? replase(HomeRoute) : replase(SignInRoute)

        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: SavingsRoute.page),
        AutoRoute(page: StatisticRoute.page),
      ];
}
