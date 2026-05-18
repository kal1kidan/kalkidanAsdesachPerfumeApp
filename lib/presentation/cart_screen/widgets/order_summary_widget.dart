
import '../../../core/app_export.dart';

class OrderSummaryWidget extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;

  const OrderSummaryWidget({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Text(
            'Order Summary',
            style: GoogleFonts.playfairDisplay(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.espresso,
            ),
          ),
          const SizedBox(height: 16),

          // Sub Total
          _SummaryRow(
            label: 'Sub Total',
            value: '\$${subtotal.toStringAsFixed(2)}',
            isHighlighted: false,
          ),
          const SizedBox(height: 10),

          // Delivery Fee
          _SummaryRow(
            label: 'Delivery Fee',
            value: '\$${deliveryFee.toStringAsFixed(2)}',
            isHighlighted: false,
            icon: Icons.local_shipping_outlined,
          ),
          const SizedBox(height: 10),

          // Discount
          if (discount > 0) ...[
            _SummaryRow(
              label: 'Coupon Discount',
              value: '- \$${discount.toStringAsFixed(2)}',
              isHighlighted: false,
              isDiscount: true,
            ),
            const SizedBox(height: 10),
          ],

          // Divider
          Container(height: 1, color: AppTheme.surfaceVariantLight),
          const SizedBox(height: 14),

          // Total
          _SummaryRow(
            label: 'Total',
            value: '\$${total.toStringAsFixed(2)}',
            isHighlighted: true,
          ),

          const SizedBox(height: 12),

          // Free delivery notice
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.success.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppTheme.success.withAlpha(51),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  size: 14,
                  color: AppTheme.success,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Free delivery on orders over \$500',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: AppTheme.success,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlighted;
  final bool isDiscount;
  final IconData? icon;

  const _SummaryRow({
    required this.label,
    required this.value,
    required this.isHighlighted,
    this.isDiscount = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: AppTheme.muted),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: GoogleFonts.dmSans(
                fontSize: isHighlighted ? 16 : 13,
                fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w400,
                color: isHighlighted ? AppTheme.espresso : AppTheme.muted,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: GoogleFonts.dmSans(
            fontSize: isHighlighted ? 20 : 13,
            fontWeight: isHighlighted ? FontWeight.w800 : FontWeight.w600,
            color: isHighlighted
                ? AppTheme.primary
                : isDiscount
                ? AppTheme.success
                : AppTheme.espresso,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
