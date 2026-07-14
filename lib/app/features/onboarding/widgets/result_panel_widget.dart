import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart'; // المكتبة لضمان الاهتزاز الفعلي

class ResultPanelWidget extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultPanelWidget({super.key, required this.result});

  Future<void> _triggerVibration() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    } else {
      HapticFeedback.heavyImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = result['status'] as String;
    final prediction = result['prediction'] as String;
    final confidence = result['confidence'] as String;

    const Color primaryBlue = Color(0xFF1E3A8A);

    Color panelColor;
    Color borderColor;
    Color textColor;
    IconData icon;
    String titleText;

    if (status == 'error') {
      panelColor = const Color(0xFFFEF3C7);
      borderColor = const Color(0xFFD97706);
      textColor = const Color(0xFFD97706);
      icon = Icons.wifi_off_rounded;
      titleText = "Connection Error";
    } else if (prediction.toUpperCase() == 'PNEUMONIA') {
      panelColor = const Color(0xFFFFECEC);
      borderColor = const Color(0xFFD32F2F);
      textColor = const Color(0xFFD32F2F);
      icon = Icons.warning_rounded;
      titleText = "Diagnosis Alert";
    } else {
      panelColor = const Color(0xFFE0F9E8);
      borderColor = const Color(0xFF2E7D32);
      textColor = const Color(0xFF2E7D32);
      icon = Icons.check_circle_rounded;
      titleText = "Diagnosis Clear";
    }

    return Container(
      key: ValueKey(prediction),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 28),
              const SizedBox(width: 10),
              Text(
                titleText,
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade800),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            prediction,
            style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: textColor, height: 1.1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Confidence: $confidence",
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: primaryBlue),
            ),
          ),
          const SizedBox(height: 24),
          Divider(color: borderColor.withOpacity(0.3), thickness: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              // زرار حفظ التقرير
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await _triggerVibration(); // اهتزاز فعلي

                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Row(
                            children: [
                              Icon(Icons.security_rounded, color: Colors.white),
                              SizedBox(width: 10),
                              Expanded(child: Text("Report saved securely.")),
                            ],
                          ),
                          backgroundColor: Colors.green.shade700,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.save_alt_rounded, size: 18, color: textColor),
                  label: Text("Save", style: GoogleFonts.poppins(color: textColor, fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: borderColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // زرار المشاركة
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await _triggerVibration(); // اهتزاز فعلي

                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Preparing secure link..."),
                          backgroundColor: primaryBlue,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.share_rounded, size: 18, color: Colors.white),
                  label: Text("Share", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}