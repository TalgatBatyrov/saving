import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:saving/app/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Future<bool> _isFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    return isFirstTime;
  }

  @override
  void initState() {
    super.initState();
    isWatchOnboarding();
  }

  void isWatchOnboarding() async {
    final router = context.router;
    final isFirstTime = await _isFirstTimeUser();
    isFirstTime
        ? router.replace(const OnBoardingRoute())
        : router.replace(const SplashRoute());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
