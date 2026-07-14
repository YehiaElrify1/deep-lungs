import 'dart:io';
import 'package:deep_lungs/app/features/onboarding/widgets/action_buttons_widget.dart';
import 'package:deep_lungs/app/features/onboarding/widgets/header_widget.dart';
import 'package:deep_lungs/app/features/onboarding/widgets/image_box_widget.dart';
import 'package:deep_lungs/app/features/onboarding/widgets/result_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/services/api_service.dart';
import 'package:flutter/services.dart';

class DetectionScreen extends StatefulWidget {
  const DetectionScreen({super.key});

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  File? _selectedImage;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();
  final ApiService _apiService = ApiService();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  // 👇 دالة جديدة لظهور النتيجة كـ Bottom Sheet احترافي
  void _showResultBottomSheet(Map<String, dynamic> resultData) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // عشان حواف الكارت بتاعنا تبان
      isScrollControlled: true, // عشان ياخد الحجم اللي محتاجه بس
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 40, left: 24, right: 24, top: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // مؤشر السحب (Drag Handle) الرمادي الصغير اللي فوق الكارت
              Container(
                height: 5,
                width: 40,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // هنا بنستدعي نفس الـ Widget بتاع النتيجة اللي فصلناه!
              ResultPanelWidget(result: resultData),
            ],
          ),
        );
      },
    );
  }

  Future<void> _runAnalysis() async {
    if (_selectedImage == null) return;

    HapticFeedback.lightImpact();

    setState(() => _isLoading = true);

    final result = await _apiService.uploadAndPredict(_selectedImage!.path);

    setState(() => _isLoading = false);

    Map<String, dynamic> finalResult;
    if (result != null && result['status'] == 'success') {
      finalResult = {
        'status': 'success',
        'prediction': result['prediction'],
        'confidence': result['confidence'],
      };
    } else {
      finalResult = {
        'status': 'error',
        'prediction': 'Connection Error',
        'confidence': 'Could not reach server',
      };
    }

    if (mounted) {
      HapticFeedback.heavyImpact();
      _showResultBottomSheet(finalResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF1E3A8A);
    const Color scaffoldBg = Color(0xFFF9FAFB);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Deep Lungs AI',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: primaryBlue),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryBlue),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderWidget(),
            const SizedBox(height: 30),

            ImageBoxWidget(selectedImage: _selectedImage),
            const SizedBox(height: 24),

            ActionButtonsWidget(
              onCameraTap: () => _pickImage(ImageSource.camera),
              onGalleryTap: () => _pickImage(ImageSource.gallery),
            ),
            const SizedBox(height: 30),

            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: _selectedImage != null && !_isLoading ? _runAnalysis : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                  shadowColor: primaryBlue.withOpacity(0.4),
                  disabledBackgroundColor: primaryBlue.withOpacity(0.5),
                ),
                child: _isLoading
                    ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                    : Text("Analyze Scan", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),

            // 💡 لاحظ هنا: شلنا الـ AnimatedSwitcher اللي كان بيعرض النتيجة تحت
            // لأن النتيجة بقت تظهر في الـ Bottom Sheet بمجرد ما الـ _runAnalysis يخلص!
          ],
        ),
      ),
    );
  }
}