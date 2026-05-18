
import '../../../core/app_export.dart';

class BrandChipRowWidget extends StatelessWidget {
  BrandChipRowWidget({super.key});

  final List<Map<String, dynamic>> _brands = [
    {
      'name': 'Chanel',
      'imageUrl':
          'https://images.unsplash.com/photo-1594913785294-799b0504a203',
      'semanticLabel': 'Classic Chanel No5 perfume bottle on white background',
    },
    {
      'name': 'Dior',
      'imageUrl':
          'https://images.unsplash.com/photo-1700240424146-98685828342f',
      'semanticLabel': 'Dior perfume bottle with golden cap on marble surface',
    },
    {
      'name': 'Tom Ford',
      'imageUrl':
          'https://images.unsplash.com/photo-1618261325436-dc799dca3874',
      'semanticLabel':
          'Dark luxury Tom Ford fragrance bottle on black background',
    },
    {
      'name': 'YSL',
      'imageUrl':
          'https://images.unsplash.com/photo-1723391962154-8a2b6299bc09',
      'semanticLabel':
          'YSL perfume bottle with golden details on beige surface',
    },
    {
      'name': 'MFK',
      'imageUrl':
          'https://images.unsplash.com/photo-1709095458514-573bc6277d3d',
      'semanticLabel':
          'Maison Francis Kurkdjian luxury perfume in clear bottle',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Text(
            'Popular Brand',
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.espresso,
            ),
          ),
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            itemCount: _brands.length,
            itemBuilder: (context, index) {
              return _BrandChipItem(brand: _brands[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _BrandChipItem extends StatelessWidget {
  final Map<String, dynamic> brand;

  const _BrandChipItem({required this.brand});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppTheme.surfaceVariantLight,
                shape: BoxShape.circle,
                boxShadow: AppTheme.softShadow,
                border: Border.all(color: AppTheme.mutedLight, width: 1),
              ),
              child: ClipOval(
                child: CustomImageWidget(
                  imageUrl: brand['imageUrl'] as String,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  semanticLabel: brand['semanticLabel'] as String,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              brand['name'] as String,
              style: GoogleFonts.dmSans(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppTheme.espresso,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
