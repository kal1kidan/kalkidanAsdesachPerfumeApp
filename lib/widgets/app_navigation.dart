import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import './custom_icon_widget.dart';

class AppNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation>
    with SingleTickerProviderStateMixin {
  late AnimationController _snakeController;
  late Animation<double> _snakeAnimation;
  int _previousIndex = 0;

  final List<_NavItem> _items = const [
    _NavItem(activeIcon: 'home', inactiveIcon: 'home_outlined', label: 'Home'),
    _NavItem(
      activeIcon: 'favorite',
      inactiveIcon: 'favorite_border',
      label: 'Wishlist',
    ),
    _NavItem(activeIcon: 'message', inactiveIcon: 'message', label: 'Message'),
    _NavItem(
      activeIcon: 'person',
      inactiveIcon: 'person_outlined',
      label: 'Profile',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _snakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _snakeAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _snakeController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didUpdateWidget(AppNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      final start = oldWidget.currentIndex.toDouble();
      final end = widget.currentIndex.toDouble();
      _snakeAnimation = Tween<double>(begin: start, end: end).animate(
        CurvedAnimation(parent: _snakeController, curve: Curves.easeOutCubic),
      );
      _snakeController.forward(from: 0);
      _previousIndex = oldWidget.currentIndex;
    }
  }

  @override
  void dispose() {
    _snakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    if (isTablet) return _buildNavigationRail();
    return _buildBottomBar();
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppTheme.espresso.withAlpha(20),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / _items.length;
              return Stack(
                children: [
                  AnimatedBuilder(
                    animation: _snakeAnimation,
                    builder: (context, _) {
                      return Positioned(
                        top: 8,
                        left: _snakeAnimation.value * itemWidth + (itemWidth - 56) / 2,
                        child: Container(
                          width: 56,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    children: List.generate(_items.length, (index) {
                      final isActive = widget.currentIndex == index;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => widget.onTap(index),
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 2),
                              CustomIconWidget(
                                iconName: isActive
                                    ? _items[index].activeIcon
                                    : _items[index].inactiveIcon,
                                color: isActive ? Colors.white : AppTheme.muted,
                                size: 22,
                              ),
                              const SizedBox(height: 3),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 200),
                                style: GoogleFonts.dmSans(
                                  fontSize: 11,
                                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                                  color: isActive ? AppTheme.primary : AppTheme.muted,
                                ),
                                child: Text(_items[index].label),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: widget.currentIndex,
      onDestinationSelected: widget.onTap,
      backgroundColor: Colors.white,
      indicatorColor: AppTheme.primary,
      selectedIconTheme: const IconThemeData(color: Colors.white, size: 22),
      unselectedIconTheme: IconThemeData(color: AppTheme.muted, size: 22),
      selectedLabelTextStyle: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppTheme.primary,
      ),
      unselectedLabelTextStyle: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppTheme.muted,
      ),
      destinations: _items
          .map(
            (item) => NavigationRailDestination(
              icon: CustomIconWidget(
                iconName: item.inactiveIcon,
                color: AppTheme.muted,
                size: 22,
              ),
              selectedIcon: CustomIconWidget(
                iconName: item.activeIcon,
                color: Colors.white,
                size: 22,
              ),
              label: Text(item.label),
            ),
          )
          .toList(),
    );
  }
}

class _NavItem {
  final String activeIcon;
  final String inactiveIcon;
  final String label;
  const _NavItem({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
  });
}
