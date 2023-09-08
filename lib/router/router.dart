import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:saving/models/saving/saving.dart';
import 'package:saving/pages/reset_password_page.dart';
import 'package:saving/pages/savings_page.dart';
import '../pages/splash_screen.dart';
import '../pages/sign_up_page.dart';
import '../pages/sing_in_page.dart';
import '../pages/verify_email_page.dart';
import '../pages/statistic_page.dart';
import '../widgets/start_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartRoute.page, initial: true),
        AutoRoute(page: SplashRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: SavingsRoute.page),
        AutoRoute(page: StatisticRoute.page),
        AutoRoute(page: VerifyEmailRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
      ];
}
