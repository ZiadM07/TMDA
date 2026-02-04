import 'package:intl/intl.dart';
import 'package:tmda/config/theme/app_color_scheme.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/actors/domain/entities/actor_details.dart';
import 'package:tmda/features/actors/presentation/cubits/actor_cubit.dart';
import 'package:tmda/features/shared/presentation/widgets/app_advanced_text.dart';
import 'package:tmda/features/shared/presentation/widgets/app_divider.dart';
import 'package:tmda/features/shared/presentation/widgets/app_svg.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';

class ActorDetailsSliverBody extends StatelessWidget {
  final ActorDetails actor;

  const ActorDetailsSliverBody({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActorDetailsCubit>();

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Column(
            children: [
              _InfoRow(
                icon: Icons.cake_outlined,
                text: _formatBirthday(actor.birthday ?? ''),
              ),
              const SizedBox(height: 10),
              _InfoRow(
                svg: Svgs.series,
                text: '${cubit.tvShowsCount} TV Shows',
              ),
              const SizedBox(height: 10),
              _InfoRow(svg: Svgs.movies, text: '${cubit.moviesCount} Movies'),
            ],
          ),
          const SizedBox(height: 20),
          AppAdvancedText(
            key: ValueKey(actor.biography),
            actor.biography ?? '',
            moreText: context.locale.readMore,
            lessText: context.locale.readLess,
            align: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const AppDivider(),
          const SizedBox(height: 16),
        ],
      ).addPadding(horizontal: 20.0),
    );
  }

  String _formatBirthday(String value) {
    if (value.isEmpty) return '-';

    try {
      final date = DateTime.parse(value);
      return DateFormat('d MMMM yyyy').format(date);
    } catch (_) {
      return value;
    }
  }
}

class _InfoRow extends StatelessWidget {
  final IconData? icon;
  final String? svg;
  final String text;

  const _InfoRow({this.icon, this.svg, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            size: 18,
            color: context.colorScheme.primary.withValues(alpha: .70),
          ),
        if (svg != null)
          AppSvg(
            width: 18,
            height: 18,
            svg!,
            color: context.colorScheme.primary.withValues(alpha: .70),
          ),
        const SizedBox(width: 10),
        AppText(
          text,
          size: 14,
          color: context.colorScheme.textSecondary,
          weight: FontWeight.w600,
        ),
      ],
    );
  }
}
