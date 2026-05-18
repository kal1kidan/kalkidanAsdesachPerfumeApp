import 'package:flutter/services.dart';

import '../../core/app_export.dart';
import './widgets/fragrance_notes_widget.dart';
import './widgets/product_cta_widget.dart';
import './widgets/product_hero_image_widget.dart';
import './widgets/product_info_header_widget.dart';
import './widgets/size_selector_widget.dart';
import './widgets/thumbnail_strip_widget.dart';

// TODO: Replace with Riverpod/Bloc for production

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImageIndex = 0;
  String _selectedSize = '50ml';
  bool _isWishlisted = false;
  int _cartCount = 0;

  final List<Map<String, dynamic>> _productImageMaps = [
    {
      'url':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1ed71a95d-1772385746267.png',
      'semanticLabel':
          'Noir de Kal perfume bottle front view on dark marble with dramatic lighting',
    },
    {
      'url':
          'https://img.rocket.new/generatedImages/rocket_gen_img_1ccd022d9-1772614920339.png',
      'semanticLabel':
          'Noir de Kal perfume bottle side angle showcasing crystal facets',
    },
    {
      'url':
          'https://images.unsplash.com/photo-1703681036028-b4dbb8811230',
      'semanticLabel':
          'Noir de Kal perfume bottle with cap removed showing golden spray nozzle',
    },
    {
      'url':
          'https://images.unsplash.com/photo-1630512873199-6b2d23e7d99a',
      'semanticLabel':
          'Noir de Kal perfume bottle on white marble with silk fabric background',
    },
  ];

  late List<ProductImage> _productImages;

  final Map<String, dynamic> _productData = {
    'id': 'noir-de-kal',
    'name': 'Noir de Kal',
    'subtitle': 'Woody Oriental Eau de Parfum',
    'price': 285.0,
    'originalPrice': 340.0,
    'rating': 4.8,
    'reviewCount': 312,
    'stockCount': 3,
    'description':
        'A masterful composition that opens with the cool freshness of black pepper and bergamot, evolving into a rich heart of leather and oud wood, finally settling into a mesmerizing base of vetiver, amber, and musk. Noir de Kal is an ode to the mysterious night.',
    'sizes': ['30ml', '50ml', '100ml'],
    'topNotes': ['Black Pepper', 'Bergamot', 'Cardamom'],
    'heartNotes': ['Leather', 'Oud Wood', 'Iris'],
    'baseNotes': ['Vetiver', 'Amber', 'White Musk', 'Sandalwood'],
    'ingredients': 'Alcohol Denat., Parfum (Fragrance), Aqua (Water)',
    'gender': 'Men',
  };

  @override
  void initState() {
    super.initState();
    _productImages = _productImageMaps.map(ProductImage.fromMap).toList();
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
          child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
        ),
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return Stack(
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildDetailAppBar()),
            SliverToBoxAdapter(
              child: ProductHeroImageWidget(
                images: _productImages,
                selectedIndex: _selectedImageIndex,
                onImageChanged: (index) =>
                    setState(() => _selectedImageIndex = index),
              ),
            ),
            SliverToBoxAdapter(
              child: ThumbnailStripWidget(
                images: _productImages,
                selectedIndex: _selectedImageIndex,
                onThumbnailTap: (index) =>
                    setState(() => _selectedImageIndex = index),
              ),
            ),
            SliverToBoxAdapter(
              child: ProductInfoHeaderWidget(
                name: _productData['name'] as String,
                subtitle: _productData['subtitle'] as String,
                price: _productData['price'] as double,
                originalPrice: _productData['originalPrice'] as double,
                rating: _productData['rating'] as double,
                reviewCount: _productData['reviewCount'] as int,
                stockCount: _productData['stockCount'] as int,
                isWishlisted: _isWishlisted,
                onWishlistToggle: () =>
                    setState(() => _isWishlisted = !_isWishlisted),
              ),
            ),
            SliverToBoxAdapter(
              child: SizeSelectorWidget(
                sizes: (_productData['sizes'] as List).cast<String>(),
                selectedSize: _selectedSize,
                onSizeSelected: (size) => setState(() => _selectedSize = size),
              ),
            ),
            SliverToBoxAdapter(child: _buildDescription()),
            SliverToBoxAdapter(
              child: FragranceNotesWidget(
                topNotes: (_productData['topNotes'] as List).cast<String>(),
                heartNotes: (_productData['heartNotes'] as List).cast<String>(),
                baseNotes: (_productData['baseNotes'] as List).cast<String>(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ProductCtaWidget(
            onAddToCart: _handleAddToCart,
            onBuyNow: _handleBuyNow,
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildDetailAppBar(),
                ProductHeroImageWidget(
                  images: _productImages,
                  selectedIndex: _selectedImageIndex,
                  onImageChanged: (index) =>
                      setState(() => _selectedImageIndex = index),
                ),
                ThumbnailStripWidget(
                  images: _productImages,
                  selectedIndex: _selectedImageIndex,
                  onThumbnailTap: (index) =>
                      setState(() => _selectedImageIndex = index),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 140),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductInfoHeaderWidget(
                      name: _productData['name'] as String,
                      subtitle: _productData['subtitle'] as String,
                      price: _productData['price'] as double,
                      originalPrice: _productData['originalPrice'] as double,
                      rating: _productData['rating'] as double,
                      reviewCount: _productData['reviewCount'] as int,
                      stockCount: _productData['stockCount'] as int,
                      isWishlisted: _isWishlisted,
                      onWishlistToggle: () =>
                          setState(() => _isWishlisted = !_isWishlisted),
                    ),
                    SizeSelectorWidget(
                      sizes: (_productData['sizes'] as List).cast<String>(),
                      selectedSize: _selectedSize,
                      onSizeSelected: (size) =>
                          setState(() => _selectedSize = size),
                    ),
                    _buildDescription(),
                    FragranceNotesWidget(
                      topNotes: (_productData['topNotes'] as List).cast<String>(),
                      heartNotes: (_productData['heartNotes'] as List).cast<String>(),
                      baseNotes: (_productData['baseNotes'] as List).cast<String>(),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ProductCtaWidget(
                  onAddToCart: _handleAddToCart,
                  onBuyNow: _handleBuyNow,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Text(
        _productData['description'] as String,
        style: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppTheme.muted,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildDetailAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
            color: AppTheme.espresso,
          ),
          Text(
            'Details',
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.espresso,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.shopping_cart_outlined),
            color: AppTheme.espresso,
          ),
        ],
      ),
    );
  }

  void _handleAddToCart() {
    setState(() => _cartCount += 1);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added ${_productData['name']} to cart',
          style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white),
        ),
        backgroundColor: AppTheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleBuyNow() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Proceeding to checkout...',
          style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white),
        ),
        backgroundColor: AppTheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
