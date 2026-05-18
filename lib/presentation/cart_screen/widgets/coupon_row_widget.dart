
import '../../../core/app_export.dart';

class CouponRowWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isApplied;
  final VoidCallback onApply;

  const CouponRowWidget({
    super.key,
    required this.controller,
    required this.isApplied,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'local_offer',
                color: AppTheme.accent,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'Have a coupon code?',
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.espresso,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Coupon text field
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariantLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isApplied
                          ? AppTheme.success.withAlpha(102)
                          : AppTheme.mutedLight,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: controller,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.espresso,
                      letterSpacing: 1.5,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter coupon code',
                      hintStyle: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: AppTheme.muted,
                        letterSpacing: 0,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      filled: false,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Available badge
              GestureDetector(
                onTap: onApply,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isApplied
                        ? AppTheme.success.withAlpha(31)
                        : AppTheme.primary,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: isApplied
                          ? AppTheme.success.withAlpha(102)
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isApplied) ...[
                        Icon(
                          Icons.check_circle_rounded,
                          size: 13,
                          color: AppTheme.success,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        isApplied ? 'Available' : 'Apply',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isApplied ? AppTheme.success : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (isApplied) ...[
            const SizedBox(height: 8),
            Text(
              '✨ Coupon applied — \$55.00 saved',
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: AppTheme.success,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
