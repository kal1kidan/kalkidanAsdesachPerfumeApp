import 'package:flutter/services.dart';

import '../../core/app_export.dart';
import './widgets/cart_item_widget.dart';
import './widgets/coupon_row_widget.dart';
import './widgets/order_summary_widget.dart';

// TODO: Replace with Riverpod/Bloc for production

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> _cartItemMaps = [
    {
      'id': 'noir-de-kal',
      'name': 'Noir de Kal',
      'subtitle': 'Woody Oriental',
      'size': '50ml',
      'price': 285.0,
      'quantity': 1,
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1faeffcd2-1775695890884.png',
      'semanticLabel':
          'Noir de Kal dark luxury perfume bottle thumbnail for cart',
    },
    {
      'id': 'amber-silk',
      'name': 'Amber Silk',
      'subtitle': 'Floral Amber',
      'size': '100ml',
      'price': 195.0,
      'quantity': 1,
      'imageUrl':
          'https://images.unsplash.com/photo-1659006026407-af59b9046ce3',
      'semanticLabel':
          'Amber Silk warm golden perfume bottle thumbnail for cart',
    },
    {
      'id': 'midnight-orchid',
      'name': 'Midnight Orchid',
      'subtitle': 'Floral Oriental',
      'size': '30ml',
      'price': 360.0,
      'quantity': 1,
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_12b1414d4-1772472764991.png',
      'semanticLabel':
          'Midnight Orchid deep purple perfume bottle thumbnail for cart',
    },
  ];

  late List<CartItem> _cartItems;
  final TextEditingController _couponController = TextEditingController();
  bool _couponApplied = true;
  final String _appliedCoupon = 'KAL2026';
  final double _deliveryFee = 13.0;
  final double _discountAmount = 55.0;

  @override
  void initState() {
    super.initState();
    _cartItems = _cartItemMaps.map(CartItem.fromMap).toList();
    _couponController.text = _appliedCoupon;
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  double get _subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  double get _total =>
      _subtotal + _deliveryFee - (_couponApplied ? _discountAmount : 0);

  void _incrementQty(int index) {
    setState(
      () => _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + 1,
      ),
    );
  }

  void _decrementQty(int index) {
    if (_cartItems[index].quantity > 1) {
      setState(
        () => _cartItems[index] = _cartItems[index].copyWith(
          quantity: _cartItems[index].quantity - 1,
        ),
      );
    }
  }

  void _removeItem(int index) {
    final removedItem = _cartItems[index];
    setState(() => _cartItems.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${removedItem.name} removed from cart',
          style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white),
        ),
        backgroundColor: AppTheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'Undo',
          textColor: AppTheme.accentLight,
          onPressed: () {
            setState(() => _cartItems.insert(index, removedItem));
          },
        ),
      ),
    );
  }

  void _handleCheckout() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _CheckoutConfirmSheet(total: _total),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        body: SafeArea(
          bottom: false,
          child: isTablet
              ? Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: _buildBody(),
                  ),
                )
              : _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Column(
          children: [
            _buildCartAppBar(),
            Expanded(
              child: _cartItems.isEmpty
                  ? EmptyStateWidget(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Your cart is empty',
                      subtitle:
                          'Add your favourite luxury fragrances\nand they\'ll appear here.',
                      ctaLabel: 'Discover Fragrances',
                      onCta: () => Navigator.pop(context),
                    )
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 160),
                      children: [
                        ...List.generate(_cartItems.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CartItemWidget(
                              item: _cartItems[index],
                              onIncrement: () => _incrementQty(index),
                              onDecrement: () => _decrementQty(index),
                              onDelete: () => _removeItem(index),
                            ),
                          );
                        }),
                        const SizedBox(height: 8),
                        CouponRowWidget(
                          controller: _couponController,
                          isApplied: _couponApplied,
                          onApply: () {
                            setState(
                              () => _couponApplied =
                                  _couponController.text.isNotEmpty,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        OrderSummaryWidget(
                          subtotal: _subtotal,
                          deliveryFee: _deliveryFee,
                          discount: _couponApplied ? _discountAmount : 0,
                          total: _total,
                        ),
                      ],
                    ),
            ),
          ],
        ),
        if (_cartItems.isNotEmpty)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildCheckoutButton(),
          ),
      ],
    );
  }

  Widget _buildCartAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
            color: AppTheme.espresso,
          ),
          Text(
            'My Cart',
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.espresso,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 18,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _handleCheckout,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Checkout - \\$${_total.toStringAsFixed(2)}',
            style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class _CheckoutConfirmSheet extends StatelessWidget {
  final double total;

  const _CheckoutConfirmSheet({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Confirm Order',
            style: GoogleFonts.playfairDisplay(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Your total is \\$${total.toStringAsFixed(2)}',
            style: GoogleFonts.dmSans(fontSize: 15, color: AppTheme.muted),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              child: Text('Confirm Purchase',
                  style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
