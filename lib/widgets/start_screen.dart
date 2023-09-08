import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:saving/router/router.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/mp4/splash_screen.mp4')
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(0.0);

    playVideo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void playVideo() async {
    _controller.play();
    await Future.delayed(const Duration(seconds: 4));
    context.router.replace(const OnBoardingRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller))
            : Container(),
      ),
    );
  }
}
