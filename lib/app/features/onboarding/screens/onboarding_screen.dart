import 'package:flutter/material.dart';
import '../../detection/screens/detection_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // محتوى الشاشات (تقدر تعدل الكلام براحتك)
  final List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Welcome to Deep Lungs",
      "description": "An advanced AI-powered ecosystem designed to assist in detecting Pneumonia from chest X-rays with high precision.",
      "icon": Icons.health_and_safety_rounded,
    },
    {
      "title": "How it Works?",
      "description": "Simply upload a chest X-ray image from your gallery or take a new one. Our Deep Learning model processes it in seconds.",
      "icon": Icons.document_scanner_rounded,
    },
    {
      "title": "Fast & Reliable Results",
      "description": "Receive instant diagnostic insights along with a confidence score to support clinical decision-making.",
      "icon": Icons.analytics_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // زرار التخطي (Skip)
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => _goToDetectionScreen(),
                child: const Text("Skip", style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
            ),

            // محتوى الصفحات
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // أيقونة كبيرة بتصميم عصري
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0F2FE), // أزرق فاتح جداً
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: const Color(0xFF06B6D4).withOpacity(0.2), blurRadius: 40, spreadRadius: 10)
                            ],
                          ),
                          child: Icon(onboardingData[index]["icon"], size: 100, color: const Color(0xFF1E3A8A)),
                        ),
                        const SizedBox(height: 60),

                        // العنوان
                        Text(
                          onboardingData[index]["title"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
                        ),
                        const SizedBox(height: 20),

                        // الوصف
                        Text(
                          onboardingData[index]["description"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // الجزء السفلي (النقاط والأزرار)
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // مؤشر الصفحات (Dots)
                  Row(
                    children: List.generate(
                      onboardingData.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 8),
                        height: 10,
                        width: _currentPage == index ? 24 : 10,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? const Color(0xFF06B6D4) : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  // زرار التالي أو البدء
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == onboardingData.length - 1) {
                        _goToDetectionScreen();
                      } else {
                        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text(
                      _currentPage == onboardingData.length - 1 ? "Get Started" : "Next",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToDetectionScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const DetectionScreen()),
    );
  }
}