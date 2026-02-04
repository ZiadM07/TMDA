import '../../../../core/constants/exports.dart';

class AppRatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final double spacing;
  final Color activeColor;
  final Color inactiveColor;

  const AppRatingBar({
    super.key,
    required this.rating,
    this.size = 18,
    this.spacing = 3,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        IconData icon;

        if (index < fullStars) {
          icon = Icons.star;
        } else if (index == fullStars && hasHalfStar) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing),
          child: Icon(
            icon,
            size: size,
            color: icon == Icons.star_border ? inactiveColor : activeColor,
          ),
        );
      }),
    );
  }
}
