import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:saving/features/auth/view/reset_password_page.dart';
import 'package:saving/features/auth/view/sign_up_page.dart';
import 'package:saving/features/auth/view/sing_in_page.dart';
import 'package:saving/features/auth/view/verify_email_page.dart';
import 'package:saving/features/onboarding/view/on_boarding_page.dart';
import 'package:saving/features/savings/repository/models/saving/saving.dart';
import 'package:saving/features/savings/view/savings_page.dart';
import 'package:saving/features/statistic/view/statistic_page.dart';
import 'package:saving/features/widgets/splash_screen.dart';
import 'package:saving/features/widgets/start_screen.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRoutes extends _$AppRoutes {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartRoute.page, initial: true),
        AutoRoute(page: OnBoardingRoute.page),
        AutoRoute(page: SplashRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: SavingsRoute.page),
        AutoRoute(page: StatisticRoute.page),
        AutoRoute(page: VerifyEmailRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
      ];
}
