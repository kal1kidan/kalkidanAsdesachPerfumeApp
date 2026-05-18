
import '../../../core/app_export.dart';

class ProductCtaWidget extends StatefulWidget {
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  const ProductCtaWidget({
    super.key,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  @override
  State<ProductCtaWidget> createState() => _ProductCtaWidgetState();
}

class _ProductCtaWidgetState extends State<ProductCtaWidget> {
  bool _addingToCart = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        boxShadow: [
          BoxShadow(
            color: AppTheme.espresso.withAlpha(20),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
          child: Row(
            children: [
              // Add to Cart — outlined pill
              Expanded(
                child: GestureDetector(
                  onTap: _addingToCart
                      ? null
                      : () async {
                          setState(() => _addingToCart = true);
                          await Future.microtask(() {});
                          widget.onAddToCart();
                          if (mounted) {
                            setState(() => _addingToCart = false);
                          }
                        },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: _addingToCart
                            ? AppTheme.mutedLight
                            : AppTheme.primary,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: _addingToCart
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.primary,
                                ),
                              ),
                            )
                          : Text(
                              'Add to Cart',
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.primary,
                              ),
                            ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Buy Now — filled gold pill
              Expanded(
                child: GestureDetector(
                  onTap: widget.onBuyNow,
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppTheme.accent,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: AppTheme.accentGlow,
                    ),
                    child: Center(
                      child: Text(
                        'Buy Now',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.espresso,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
