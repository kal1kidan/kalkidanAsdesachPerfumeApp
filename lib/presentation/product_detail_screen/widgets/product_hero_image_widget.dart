
import '../../../core/app_export.dart';
import '../product_detail_screen.dart';

class ProductHeroImageWidget extends StatefulWidget {
  final List<ProductImage> images;
  final int selectedIndex;
  final ValueChanged<int> onImageChanged;

  const ProductHeroImageWidget({
    super.key,
    required this.images,
    required this.selectedIndex,
    required this.onImageChanged,
  });

  @override
  State<ProductHeroImageWidget> createState() => _ProductHeroImageWidgetState();
}

class _ProductHeroImageWidgetState extends State<ProductHeroImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnim = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );
    _scaleController.forward();
  }

  @override
  void didUpdateWidget(ProductHeroImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _scaleController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < -200) {
          final next = (widget.selectedIndex + 1) % widget.images.length;
          widget.onImageChanged(next);
        } else if (details.primaryVelocity! > 200) {
          final prev =
              (widget.selectedIndex - 1 + widget.images.length) %
              widget.images.length;
          widget.onImageChanged(prev);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: screenWidth * 0.75,
        decoration: BoxDecoration(
          color: AppTheme.surfaceVariantLight,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withAlpha(31),
              blurRadius: 32,
              offset: const Offset(0, 12),
              spreadRadius: -4,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Subtle gradient background
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.8,
                    colors: [
                      AppTheme.nudePink.withAlpha(102),
                      AppTheme.surfaceVariantLight,
                    ],
                  ),
                ),
              ),
              // Product image with scale animation
              AnimatedBuilder(
                animation: _scaleAnim,
                builder: (context, child) {
                  return Transform.scale(scale: _scaleAnim.value, child: child);
                },
                child: Hero(
                  tag: 'product-image-noir-de-kal',
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: CustomImageWidget(
                      key: ValueKey(widget.selectedIndex),
                      imageUrl: widget.images[widget.selectedIndex].url,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      semanticLabel:
                          widget.images[widget.selectedIndex].semanticLabel,
                    ),
                  ),
                ),
              ),
              // Dot indicator overlay at bottom
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.images.length, (i) {
                    final isActive = i == widget.selectedIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppTheme.primary
                            : AppTheme.mutedLight,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
