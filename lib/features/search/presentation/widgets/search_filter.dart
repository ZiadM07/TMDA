import '../../../../core/constants/exports.dart';
import '../../../../core/utils/enums.dart';
import '../../../shared/presentation/widgets/app_text.dart';

class SearchFilterChips extends StatelessWidget {
  final SearchFilter selectedFilter;
  final ValueChanged<SearchFilter> onFilterChanged;
  final Map<SearchFilter, int> resultCounts;

  const SearchFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.resultCounts,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        physics: const BouncingScrollPhysics(),
        children: [
          _SearchFilterTab(
            label: context.locale.movies,
            filter: SearchFilter.movies,
            selectedFilter: selectedFilter,
            count: resultCounts[SearchFilter.movies] ?? 0,
            onTap: onFilterChanged,
          ),
          const SizedBox(width: 5),
          _SearchFilterTab(
            label: context.locale.tvShows,
            filter: SearchFilter.tv,
            selectedFilter: selectedFilter,
            count: resultCounts[SearchFilter.tv] ?? 0,
            onTap: onFilterChanged,
          ),
          const SizedBox(width: 5),
          _SearchFilterTab(
            label: context.locale.actors,
            filter: SearchFilter.people,
            selectedFilter: selectedFilter,
            count: resultCounts[SearchFilter.people] ?? 0,
            onTap: onFilterChanged,
          ),
        ],
      ),
    );
  }
}

class _SearchFilterTab extends StatelessWidget {
  final String label;
  final SearchFilter filter;
  final SearchFilter selectedFilter;
  final int count;
  final ValueChanged<SearchFilter> onTap;

  const _SearchFilterTab({
    required this.label,
    required this.filter,
    required this.selectedFilter,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final isSelected = selectedFilter == filter;

    return GestureDetector(
      onTap: () => onTap(filter),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutCubic,
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: isSelected
              ? cs.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? Border.all(color: cs.primary.withValues(alpha: 0.25), width: 1)
              : null,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              label,
              size: 14,
              weight: FontWeight.w500,
              color: isSelected
                  ? cs.primary
                  : cs.onSurface.withValues(alpha: 0.75),
              maxLines: 1,
            ),
            if (count > 0) ...[
              const SizedBox(width: 6),
              _CountBadge(count: count, isSelected: isSelected),
            ],
          ],
        ),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  final int count;
  final bool isSelected;

  const _CountBadge({required this.count, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected
            ? cs.primary.withValues(alpha: 0.2)
            : cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        count.toString(),
        style: context.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: isSelected ? cs.primary : cs.onSurfaceVariant,
        ),
      ),
    );
  }
}




// class SearchFilterChips extends StatelessWidget {
//   final SearchFilter selectedFilter;
//   final ValueChanged<SearchFilter> onFilterChanged;
//   final Map<SearchFilter, int> resultCounts;

//   const SearchFilterChips({
//     super.key,
//     required this.selectedFilter,
//     required this.onFilterChanged,
//     required this.resultCounts,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         physics: const BouncingScrollPhysics(),
//         child: Row(
//           children: [
//             _buildFilterChip(
//               context,
//               label: context.locale.movies,
//               filter: SearchFilter.movies,
//               count: resultCounts[SearchFilter.movies] ?? 0,
//             ),
//             const SizedBox(width: 10),
//             _buildFilterChip(
//               context,
//               label: context.locale.tvShows,
//               filter: SearchFilter.tv,
//               count: resultCounts[SearchFilter.tv] ?? 0,
//             ),
//             const SizedBox(width: 10),
//             _buildFilterChip(
//               context,
//               label: context.locale.actors,
//               filter: SearchFilter.people,
//               count: resultCounts[SearchFilter.people] ?? 0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFilterChip(
//     BuildContext context, {
//     required String label,
//     required SearchFilter filter,
//     required int count,
//   }) {
//     final isSelected = selectedFilter == filter;

//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       curve: Curves.easeInOut,
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => onFilterChanged(filter),
//           borderRadius: BorderRadius.circular(20),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             curve: Curves.easeInOut,
//             padding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 10,
//             ),
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? context.colorScheme.primaryContainer
//                   : context.colorScheme.surfaceContainerHighest,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: isSelected
//                     ? context.colorScheme.primary.withValues(alpha: 0.3)
//                     : Colors.transparent,
//                 width: 1.5,
//               ),
//               boxShadow: isSelected
//                   ? [
//                       BoxShadow(
//                         color: context.colorScheme.primary.withValues(alpha: 0.15),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ]
//                   : [],
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   label,
//                   style: context.textTheme.bodyMedium?.copyWith(
//                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                     color: isSelected
//                         ? context.colorScheme.onPrimaryContainer
//                         : context.colorScheme.onSurface,
//                   ),
//                 ),
//                 if (count > 0) ...[
//                   const SizedBox(width: 8),
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 2,
//                     ),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? context.colorScheme.primary.withValues(alpha: 0.2)
//                           : context.colorScheme.surfaceContainerHigh,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       count.toString(),
//                       style: context.textTheme.labelSmall?.copyWith(
//                         fontWeight: FontWeight.w600,
//                         color: isSelected
//                             ? context.colorScheme.primary
//                             : context.colorScheme.onSurfaceVariant,
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }