
import '../../../core/app_export.dart';

class FragranceNotesWidget extends StatefulWidget {
  final List<String> topNotes;
  final List<String> heartNotes;
  final List<String> baseNotes;

  const FragranceNotesWidget({
    super.key,
    required this.topNotes,
    required this.heartNotes,
    required this.baseNotes,
  });

  @override
  State<FragranceNotesWidget> createState() => _FragranceNotesWidgetState();
}

class _FragranceNotesWidgetState extends State<FragranceNotesWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _expandController;
  late Animation<double> _expandAnim;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _expandAnim = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Column(
          children: [
            // Header — tappable to expand
            GestureDetector(
              onTap: _toggleExpand,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomIconWidget(
                        iconName: 'spa',
                        color: AppTheme.primary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Fragrance Notes',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.espresso,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      child: CustomIconWidget(
                        iconName: 'expand_more',
                        color: AppTheme.muted,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Expandable notes content
            SizeTransition(
              sizeFactor: _expandAnim,
              child: FadeTransition(
                opacity: _expandAnim,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  child: Column(
                    children: [
                      const Divider(height: 1),
                      const SizedBox(height: 16),
                      _NoteRow(
                        tier: 'Top Notes',
                        icon: 'water_drop',
                        iconColor: const Color(0xFF4FC3F7),
                        notes: widget.topNotes,
                        description:
                            'The opening impression — the first 15 minutes',
                      ),
                      const SizedBox(height: 14),
                      _NoteRow(
                        tier: 'Heart Notes',
                        icon: 'favorite',
                        iconColor: AppTheme.primary,
                        notes: widget.heartNotes,
                        description:
                            'The soul of the fragrance — 30 minutes to 2 hours',
                      ),
                      const SizedBox(height: 14),
                      _NoteRow(
                        tier: 'Base Notes',
                        icon: 'spa',
                        iconColor: AppTheme.accent,
                        notes: widget.baseNotes,
                        description: 'The lasting impression — 4 to 8 hours',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteRow extends StatelessWidget {
  final String tier;
  final String icon;
  final Color iconColor;
  final List<String> notes;
  final String description;

  const _NoteRow({
    required this.tier,
    required this.icon,
    required this.iconColor,
    required this.notes,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: iconColor.withAlpha(31),
            shape: BoxShape.circle,
          ),
          child: CustomIconWidget(iconName: icon, color: iconColor, size: 15),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tier,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.espresso,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: AppTheme.muted,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: notes.map((note) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceVariantLight,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppTheme.mutedLight, width: 1),
                    ),
                    child: Text(
                      note,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.espresso,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
