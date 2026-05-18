
import '../../../core/app_export.dart';

class ProductInfoHeaderWidget extends StatefulWidget {
  final String name;
  final String subtitle;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final int stockCount;
  final bool isWishlisted;
  final VoidCallback onWishlistToggle;

  const ProductInfoHeaderWidget({
    super.key,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.stockCount,
    required this.isWishlisted,
    required this.onWishlistToggle,
  });

  @override
  State<ProductInfoHeaderWidget> createState() =>
      _ProductInfoHeaderWidgetState();
}

class _ProductInfoHeaderWidgetState extends State<ProductInfoHeaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _heartController;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasDiscount = widget.originalPrice > widget.price;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + wishlist
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.espresso,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppTheme.muted,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.onWishlistToggle();
                  _heartController.forward().then(
                    (_) => _heartController.reverse(),
                  );
                },
                child: AnimatedBuilder(
                  animation: _heartController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale:
                          1.0 +
                          (_heartController.value * 0.3) -
                          (_heartController.value *
                              _heartController.value *
                              0.15),
                      child: child,
                    );
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: widget.isWishlisted
                          ? AppTheme.primary.withAlpha(20)
                          : AppTheme.surfaceVariantLight,
                      shape: BoxShape.circle,
                    ),
                    child: CustomIconWidget(
                      iconName: widget.isWishlisted
                          ? 'favorite'
                          : 'favorite_border',
                      color: widget.isWishlisted
                          ? AppTheme.primary
                          : AppTheme.muted,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Price row
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '\$${widget.price.toStringAsFixed(0)}',
                style: GoogleFonts.dmSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primary,
                  fontFeatures: [const FontFeature.tabularFigures()],
                ),
              ),
              if (hasDiscount) ...[
                const SizedBox(width: 10),
                Text(
                  '\$${widget.originalPrice.toStringAsFixed(0)}',
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.muted,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withAlpha(26),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '${(((widget.originalPrice - widget.price) / widget.originalPrice) * 100).round()}% OFF',
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 12),

          // Stock + Rating row
          Row(
            children: [
              StatusBadgeWidget(
                type: widget.stockCount <= 5
                    ? BadgeType.lowStock
                    : BadgeType.available,
                customLabel: widget.stockCount <= 5
                    ? '${widget.stockCount} Pair Left'
                    : 'In Stock',
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E6),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: const Color(0xFFFFD166).withAlpha(128),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 13,
                      color: Color(0xFFFFB800),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.rating}',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.espresso,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${widget.reviewCount} Reviews)',
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        color: AppTheme.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
