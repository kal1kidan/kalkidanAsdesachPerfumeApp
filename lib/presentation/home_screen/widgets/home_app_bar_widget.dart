
import '../../../core/app_export.dart';

class HomeAppBarWidget extends StatefulWidget {
  final bool isSearchOpen;
  final TextEditingController searchController;
  final VoidCallback onSearchToggle;
  final int cartItemCount;
  final VoidCallback onCartTap;

  const HomeAppBarWidget({
    super.key,
    required this.isSearchOpen,
    required this.searchController,
    required this.onSearchToggle,
    required this.cartItemCount,
    required this.onCartTap,
  });

  @override
  State<HomeAppBarWidget> createState() => _HomeAppBarWidgetState();
}

class _HomeAppBarWidgetState extends State<HomeAppBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _searchAnim;
  late Animation<double> _searchWidth;

  @override
  void initState() {
    super.initState();
    _searchAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _searchWidth = CurvedAnimation(
      parent: _searchAnim,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void didUpdateWidget(HomeAppBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSearchOpen != oldWidget.isSearchOpen) {
      if (widget.isSearchOpen) {
        _searchAnim.forward();
      } else {
        _searchAnim.reverse();
      }
    }
  }

  @override
  void dispose() {
    _searchAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundLight,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          // Hamburger
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariantLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: CustomIconWidget(
                iconName: 'menu',
                color: AppTheme.espresso,
                size: 20,
              ),
            ),
          ),

          // Logo / Search field
          Expanded(
            child: AnimatedBuilder(
              animation: _searchWidth,
              builder: (context, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: widget.isSearchOpen
                      ? _buildSearchField()
                      : _buildLogo(),
                );
              },
            ),
          ),

          // Search icon
          GestureDetector(
            onTap: widget.onSearchToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.isSearchOpen
                    ? AppTheme.primary.withAlpha(26)
                    : AppTheme.surfaceVariantLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomIconWidget(
                iconName: widget.isSearchOpen ? 'close' : 'search',
                color: widget.isSearchOpen
                    ? AppTheme.primary
                    : AppTheme.espresso,
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Cart
          GestureDetector(
            onTap: widget.onCartTap,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariantLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomIconWidget(
                    iconName: 'shopping_cart',
                    color: AppTheme.espresso,
                    size: 20,
                  ),
                ),
                if (widget.cartItemCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: AppTheme.accent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          '${widget.cartItemCount}',
                          style: GoogleFonts.dmSans(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
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

  Widget _buildLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'KAL',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppTheme.primary,
            letterSpacing: 4,
          ),
        ),
        Text(
          'PERFUMES',
          style: GoogleFonts.dmSans(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: AppTheme.accent,
            letterSpacing: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariantLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primary.withAlpha(77), width: 1),
      ),
      child: TextField(
        controller: widget.searchController,
        autofocus: true,
        style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.espresso),
        decoration: InputDecoration(
          hintText: 'Search fragrances...',
          hintStyle: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.muted),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          filled: false,
        ),
      ),
    );
  }
}
