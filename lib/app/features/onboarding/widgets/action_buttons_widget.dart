import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButtonsWidget extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const ActionButtonsWidget({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF1E3A8A);

    return Row(
      children: [
        Expanded(child: _buildActionButton(Icons.camera_alt_rounded, "Camera", onCameraTap, primaryBlue)),
        const SizedBox(width: 16),
        Expanded(child: _buildActionButton(Icons.photo_library_rounded, "Gallery", onGalleryTap, primaryBlue)),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed, Color primaryColor) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: const Color(0xFF06B6D4)),
      label: Text(label, style: GoogleFonts.poppins(color: primaryColor, fontWeight: FontWeight.w600)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(color: Colors.grey.shade300, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
      ),
    );
  }
}