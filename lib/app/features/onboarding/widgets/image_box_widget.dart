import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageBoxWidget extends StatelessWidget {
  final File? selectedImage;

  const ImageBoxWidget({super.key, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    const Color accentCyan = Color(0xFF06B6D4);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: selectedImage == null
          ? _buildEmptyState(accentCyan)
          : _buildImagePreview(),
    );
  }

  Widget _buildEmptyState(Color accentColor) {
    return Container(
      key: const ValueKey('empty_state'),
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200, width: 2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, spreadRadius: 5, offset: const Offset(0, 10))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image_outlined, size: 70, color: accentColor.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            "Awaiting Image",
            style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      key: const ValueKey('image_preview'),
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Image.file(selectedImage!, fit: BoxFit.cover),
      ),
    );
  }
}