import 'package:deep_lungs/app/features/splash_screen/screens/video_splash_screen.dart';
import 'package:flutter/material.dart';
import 'app/core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pneumonia Detector',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const VideoSplashScreen(),
    );
  }
}