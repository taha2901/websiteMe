
import 'package:flutter/material.dart';
import 'package:websiteme/core/constants/app_colors.dart';

/// ==================== ANALYTICS SCREEN ====================
class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics, size: 100, color: AppColors.textLight),
          SizedBox(height: 24),
          Text(
            'Analytics & Reports',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            'Coming Soon',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
