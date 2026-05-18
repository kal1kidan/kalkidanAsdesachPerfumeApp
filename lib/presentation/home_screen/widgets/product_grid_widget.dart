
import '../../../core/app_export.dart';
import './product_card_widget.dart';

// TODO: Replace with Riverpod/Bloc for production

class ProductGridWidget extends StatefulWidget {
  final String selectedCategory;
  final void Function(String productId) onProductTap;

  const ProductGridWidget({
    super.key,
    required this.selectedCategory,
    required this.onProductTap,
  });

  @override
  State<ProductGridWidget> createState() => _ProductGridWidgetState();
}

class _ProductGridWidgetState extends State<ProductGridWidget> {
  final List<Map<String, dynamic>> _allProductMaps = [
    {
      'id': 'noir-de-kal',
      'name': 'Noir de Kal',
      'subtitle': 'Woody Oriental',
      'category': 'Men',
      'price': 285.0,
      'originalPrice': 340.0,
      'rating': 4.8,
      'reviewCount': 312,
      'isWishlisted': false,
      'stockCount': 3,
      'badgeType': 'lowStock',
      'imageUrl':
          'https://images.unsplash.com/photo-1584113418623-501a8b9774e4',
      'semanticLabel':
          'Dark luxury perfume bottle with black cap on marble surface with moody studio lighting',
    },
    {
      'id': 'velvet-oud',
      'name': 'Velvet Oud Essence',
      'subtitle': 'Oud Collection',
      'category': 'Oud Collection',
      'price': 420.0,
      'originalPrice': 420.0,
      'rating': 4.9,
      'reviewCount': 198,
      'isWishlisted': true,
      'stockCount': 12,
      'badgeType': 'available',
      'imageUrl':
          'https://images.unsplash.com/photo-1645295596047-d480d2b303bd',
      'semanticLabel':
          'Ornate golden perfume bottle with Arabic calligraphy on dark velvet background',
    },
    {
      'id': 'amber-silk',
      'name': 'Amber Silk',
      'subtitle': 'Floral Amber',
      'category': 'Women',
      'price': 195.0,
      'originalPrice': 250.0,
      'rating': 4.7,
      'reviewCount': 445,
      'isWishlisted': false,
      'stockCount': 8,
      'badgeType': 'sale',
      'imageUrl':
          'https://images.unsplash.com/photo-1705936119725-f893c63ce939',
      'semanticLabel':
          'Elegant amber-colored perfume bottle on silk fabric with soft warm lighting',
    },
    {
      'id': 'rose-mystique',
      'name': 'Rose Mystique',
      'subtitle': 'Floral Chypre',
      'category': 'Women',
      'price': 310.0,
      'originalPrice': 310.0,
      'rating': 4.6,
      'reviewCount': 267,
      'isWishlisted': false,
      'stockCount': 15,
      'badgeType': 'newArrival',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_19e086e2c-1771901389674.png',
      'semanticLabel':
          'Rose pink perfume bottle surrounded by fresh rose petals on white marble',
    },
    {
      'id': 'golden-musk',
      'name': 'Golden Musk',
      'subtitle': 'Musky Floral',
      'category': 'Unisex',
      'price': 240.0,
      'originalPrice': 240.0,
      'rating': 4.5,
      'reviewCount': 389,
      'isWishlisted': true,
      'stockCount': 20,
      'badgeType': 'available',
      'imageUrl':
          'https://img.rocket.new/generatedImages/rocket_gen_img_13023d63e-1771623614184.png',
      'semanticLabel':
          'Gold and cream perfume bottle with minimalist design on white background',
    },
    {
      'id': 'midnight-orchid',
      'name': 'Midnight Orchid',
      'subtitle': 'Floral Oriental',
      'category': 'Unisex',
      'price': 360.0,
      'originalPrice': 400.0,
      'rating': 4.9,
      'reviewCount': 156,
      'isWishlisted': false,
      'stockCount': 5,
      'badgeType': 'lowStock',
      'imageUrl':
          'https://images.unsplash.com/photo-1705936117699-57d777ecadad',
      'semanticLabel':
          'Deep purple and midnight blue perfume bottle with orchid flower accents on dark background',
    },
  ];

  late List<PerfumeProduct> _allProducts;
  List<PerfumeProduct> _filteredProducts = [];
  final Set<String> _wishlistedIds = {};

  @override
  void initState() {
    super.initState();
    _allProducts = _allProductMaps.map(PerfumeProduct.fromMap).toList();
    for (final p in _allProducts) {
      if (p.isWishlisted) _wishlistedIds.add(p.id);
    }
    _filterProducts();
  }

  @override
  void didUpdateWidget(ProductGridWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategory != widget.selectedCategory) {
      _filterProducts();
    }
  }

  void _filterProducts() {
    setState(() {
      if (widget.selectedCategory == 'All') {
        _filteredProducts = List.from(_allProducts);
      } else {
        _filteredProducts = _allProducts
            .where((p) => p.category == widget.selectedCategory)
            .toList();
      }
    });
  }

  void _toggleWishlist(String productId) {
    // TODO: Replace with Riverpod/Bloc for production
    setState(() {
      if (_wishlistedIds.contains(productId)) {
        _wishlistedIds.remove(productId);
      } else {
        _wishlistedIds.add(productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final crossAxisCount = isTablet ? 3 : 2;

    if (_filteredProducts.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.spa_rounded,
        title: 'No fragrances found',
        subtitle:
            'We don\'t have ${widget.selectedCategory} fragrances yet.\nCheck back soon for new arrivals.',
        ctaLabel: 'Browse All',
        onCta: () {},
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.68,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return _AnimatedProductCard(
          index: index,
          child: ProductCardWidget(
            product: product,
            isWishlisted: _wishlistedIds.contains(product.id),
            onWishlistToggle: () => _toggleWishlist(product.id),
            onTap: () => widget.onProductTap(product.id),
            onAddToCart: () {
              // TODO: Replace with Riverpod/Bloc for production
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${product.name} added to cart',
                    style: GoogleFonts.dmSans(fontSize: 13),
                  ),
                  backgroundColor: AppTheme.primary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _AnimatedProductCard extends StatefulWidget {
  final int index;
  final Widget child;

  const _AnimatedProductCard({required this.index, required this.child});

  @override
  State<_AnimatedProductCard> createState() => _AnimatedProductCardState();
}

class _AnimatedProductCardState extends State<_AnimatedProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    final delay = (widget.index * 60).clamp(0, 360);
    Future.microtask(() async {
      await Future.delayed(Duration(milliseconds: delay));
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

// ── Data Model ────────────────────────────────────────────────

class PerfumeProduct {
  final String id;
  final String name;
  final String subtitle;
  final String category;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final bool isWishlisted;
  final int stockCount;
  final String badgeType;
  final String imageUrl;
  final String semanticLabel;

  PerfumeProduct({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.category,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.isWishlisted,
    required this.stockCount,
    required this.badgeType,
    required this.imageUrl,
    required this.semanticLabel,
  });

  factory PerfumeProduct.fromMap(Map<String, dynamic> map) {
    return PerfumeProduct(
      id: map['id'] as String,
      name: map['name'] as String,
      subtitle: map['subtitle'] as String,
      category: map['category'] as String,
      price: (map['price'] as num).toDouble(),
      originalPrice: (map['originalPrice'] as num).toDouble(),
      rating: (map['rating'] as num).toDouble(),
      reviewCount: map['reviewCount'] as int,
      isWishlisted: map['isWishlisted'] as bool,
      stockCount: map['stockCount'] as int,
      badgeType: map['badgeType'] as String,
      imageUrl: map['imageUrl'] as String,
      semanticLabel: map['semanticLabel'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'subtitle': subtitle,
    'category': category,
    'price': price,
    'originalPrice': originalPrice,
    'rating': rating,
    'reviewCount': reviewCount,
    'isWishlisted': isWishlisted,
    'stockCount': stockCount,
    'badgeType': badgeType,
    'imageUrl': imageUrl,
    'semanticLabel': semanticLabel,
  };
}
