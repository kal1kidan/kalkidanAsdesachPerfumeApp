
import '../../../core/app_export.dart';

class SizeSelectorWidget extends StatelessWidget {
  final List<String> sizes;
  final String selectedSize;
  final ValueChanged<String> onSizeSelected;

  const SizeSelectorWidget({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Size',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.espresso,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'info',
                      color: AppTheme.accent,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Size Guide',
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: sizes.map((size) {
              final isSelected = size == selectedSize;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => onSizeSelected(size),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primary : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primary
                            : AppTheme.mutedLight,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? AppTheme.softShadow : null,
                    ),
                    child: Text(
                      size,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppTheme.espresso,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
