
import '../../../core/app_export.dart';
import '../product_detail_screen.dart';

class ThumbnailStripWidget extends StatelessWidget {
  final List<ProductImage> images;
  final int selectedIndex;
  final ValueChanged<int> onThumbnailTap;

  const ThumbnailStripWidget({
    super.key,
    required this.images,
    required this.selectedIndex,
    required this.onThumbnailTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(images.length, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onThumbnailTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? AppTheme.primary : AppTheme.mutedLight,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected ? AppTheme.softShadow : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(color: AppTheme.surfaceVariantLight),
                    CustomImageWidget(
                      imageUrl: images[index].url,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      semanticLabel: images[index].semanticLabel,
                    ),
                    if (!isSelected)
                      Container(color: Colors.white.withAlpha(89)),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
