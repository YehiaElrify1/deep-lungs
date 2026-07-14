import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../detection/screens/detection_screen.dart';
import '../../onboarding/screens/onboarding_screen.dart';

class VideoSplashScreen extends StatefulWidget {
  const VideoSplashScreen({super.key});

  @override
  State<VideoSplashScreen> createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    // 1. تحديد مسار الفيديو وتحميله
    _controller = VideoPlayerController.asset('assets/splash_video.mp4')
      ..initialize().then((_) {
        // 2. أول ما يحمل، اعمل تحديث للشاشة وشغل الفيديو
        setState(() {
          _isInitialized = true;
        });
        _controller.play();
      });

    // 3. مراقبة الفيديو عشان نعرف إمتى يخلص
    _controller.addListener(() {
      // لو وقت التشغيل وصل لنهاية مدة الفيديو
      if (_controller.value.position >= _controller.value.duration) {
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _isInitialized
            ? SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
        )
            : const CircularProgressIndicator(color: Color(0xFF1E3A8A)),
      ),
    );
  }
}