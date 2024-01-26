import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:saving/app/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  Widget buildImage(String imagePath) {
    return Image.asset(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Добавляйте цели',
          body: 'Добавляйте цели и следите за их выполнением',
          image: buildImage("assets/png/add_saving.png"),
          decoration: const PageDecoration(
            imagePadding: EdgeInsets.only(top: 120),
            contentMargin: EdgeInsets.symmetric(horizontal: 16),
            pageColor: Colors.white10,
            bodyFlex: 2,
            imageFlex: 3,
            bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
            titlePadding: EdgeInsets.only(top: 50),
            bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
          ),
        ),
        PageViewModel(
          title: 'Пополняйте накопления',
          body: 'Пополняйте накопления и отслеживайте прогресс',
          image: buildImage("assets/png/saving.png"),
          decoration: const PageDecoration(
            imagePadding: EdgeInsets.only(top: 120),
            pageColor: Colors.white10,
            bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
            titlePadding: EdgeInsets.only(top: 50),
            bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
          ),
        ),
        PageViewModel(
          title: 'Получайте статистику',
          body: 'Получайте статистику по каждому накоплению',
          image: buildImage("assets/png/statistic.png"),
          decoration: const PageDecoration(
            imagePadding: EdgeInsets.only(top: 120),
            pageColor: Colors.white10,
            bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
            titlePadding: EdgeInsets.only(top: 50),
            bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
          ),
        ),
      ],
      onDone: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isFirstTime', false);

        router.replace(const SplashRoute());
      },
      scrollPhysics: const ClampingScrollPhysics(),
      showDoneButton: true,
      showNextButton: true,
      showSkipButton: true,
      skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        spacing: EdgeInsets.symmetric(horizontal: 2),
        activeColor: Colors.indigo,
        color: Colors.grey,
        activeSize: Size(12, 5),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
