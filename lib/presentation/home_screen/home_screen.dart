import 'package:flutter/services.dart';

import '../../core/app_export.dart';
import '../../widgets/app_navigation.dart';
import './widgets/brand_chip_row_widget.dart';
import './widgets/hero_banner_widget.dart';
import './widgets/home_app_bar_widget.dart';
import './widgets/product_grid_widget.dart';

// TODO: Replace with Riverpod/Bloc for production

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentNavIndex = 0;
  bool _isSearchOpen = false;
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<String> _categories = [
    'All',
    'Women',
    'Men',
    'Unisex',
    'Oud Collection',
    'New Arrivals',
  ];

  int _selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _selectedCategory = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
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
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
        ),
        bottomNavigationBar: isTablet
            ? null
            : AppNavigation(
                currentIndex: _currentNavIndex,
                onTap: (index) => setState(() => _currentNavIndex = index),
              ),
        floatingActionButton: null,
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return Column(
      children: [
        HomeAppBarWidget(
          isSearchOpen: _isSearchOpen,
          searchController: _searchController,
          onSearchToggle: () => setState(() => _isSearchOpen = !_isSearchOpen),
          cartItemCount: 3,
          onCartTap: () => Navigator.pushNamed(context, AppRoutes.cartScreen),
        ),
        Expanded(child: _buildScrollContent()),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        AppNavigation(
          currentIndex: _currentNavIndex,
          onTap: (index) => setState(() => _currentNavIndex = index),
        ),
        Expanded(
          child: Column(
            children: [
              HomeAppBarWidget(
                isSearchOpen: _isSearchOpen,
                searchController: _searchController,
                onSearchToggle: () =>
                    setState(() => _isSearchOpen = !_isSearchOpen),
                cartItemCount: 3,
                onCartTap: () =>
                    Navigator.pushNamed(context, AppRoutes.cartScreen),
              ),
              Expanded(child: _buildScrollContent()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScrollContent() {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: HeroBannerWidget(onShopNow: () {}),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: BrandChipRowWidget(),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _CategoryTabDelegate(
            tabController: _tabController,
            categories: _categories,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: ProductGridWidget(
              selectedCategory: _categories[_selectedCategory],
              onProductTap: (productId) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.productDetailScreen,
                  arguments: productId,
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}

class _CategoryTabDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  final List<String> categories;

  _CategoryTabDelegate({required this.tabController, required this.categories});

  @override
  double get minExtent => 52;
  @override
  double get maxExtent => 52;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppTheme.backgroundLight,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        tabAlignment: TabAlignment.start,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        tabs: categories.asMap().entries.map((entry) {
          final isSelected = tabController.index == entry.key;
          return Tab(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primary
                    : AppTheme.surfaceVariantLight,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                entry.value,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppTheme.muted,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  bool shouldRebuild(_CategoryTabDelegate oldDelegate) => true;
}
