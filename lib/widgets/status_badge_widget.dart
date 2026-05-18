import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

enum BadgeType { available, lowStock, outOfStock, sale, newArrival, featured }

class StatusBadgeWidget extends StatelessWidget {
  final BadgeType type;
  final String? customLabel;

  const StatusBadgeWidget({super.key, required this.type, this.customLabel});

  @override
  Widget build(BuildContext context) {
    final config = _getBadgeConfig(type);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: config.borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (config.icon != null) ...[
            Icon(config.icon, size: 10, color: config.textColor),
            const SizedBox(width: 3),
          ],
          Text(
            customLabel ?? config.label,
            style: GoogleFonts.dmSans(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: config.textColor,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  _BadgeConfig _getBadgeConfig(BadgeType type) {
    switch (type) {
      case BadgeType.available:
        return _BadgeConfig(
          label: 'In Stock',
          backgroundColor: AppTheme.success.withAlpha(26),
          borderColor: AppTheme.success.withAlpha(77),
          textColor: AppTheme.success,
          icon: Icons.check_circle_rounded,
        );
      case BadgeType.lowStock:
        return _BadgeConfig(
          label: 'Only a Few Left',
          backgroundColor: AppTheme.warning.withAlpha(26),
          borderColor: AppTheme.warning.withAlpha(77),
          textColor: AppTheme.warning,
          icon: Icons.warning_amber_rounded,
        );
      case BadgeType.outOfStock:
        return _BadgeConfig(
          label: 'Out of Stock',
          backgroundColor: AppTheme.error.withAlpha(26),
          borderColor: AppTheme.error.withAlpha(77),
          textColor: AppTheme.error,
        );
      case BadgeType.sale:
        return _BadgeConfig(
          label: 'SALE',
          backgroundColor: AppTheme.primary.withAlpha(26),
          borderColor: AppTheme.primary.withAlpha(77),
          textColor: AppTheme.primary,
          icon: Icons.local_offer_rounded,
        );
      case BadgeType.newArrival:
        return _BadgeConfig(
          label: 'New Arrival',
          backgroundColor: AppTheme.accent.withAlpha(38),
          borderColor: AppTheme.accent.withAlpha(102),
          textColor: const Color(0xFF8B6914),
          icon: Icons.auto_awesome_rounded,
        );
      case BadgeType.featured:
        return _BadgeConfig(
          label: 'Featured',
          backgroundColor: AppTheme.primaryContainer,
          borderColor: AppTheme.primary.withAlpha(51),
          textColor: AppTheme.primary,
        );
    }
  }
}

class _BadgeConfig {
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final IconData? icon;

  _BadgeConfig({
    required this.label,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    this.icon,
  });
}
