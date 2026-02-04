import 'package:tmda/config/theme/app_color_scheme.dart';
import 'package:tmda/core/state/app_state.dart';
import 'package:tmda/core/state/state_handler.dart';
import 'package:tmda/core/utils/enums.dart';
import 'package:tmda/features/search/presentation/cubits/search_cubit.dart';
import 'package:tmda/features/search/presentation/widgets/search_empty_state.dart';
import 'package:tmda/features/search/presentation/widgets/search_field.dart';
import 'package:tmda/features/search/presentation/widgets/search_filter.dart';
import 'package:tmda/features/search/presentation/widgets/search_results_list.dart';
import 'package:tmda/features/shared/presentation/widgets/app_loading.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';

import '../../../../core/constants/exports.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Map<SearchFilter, int> _resultCounts(SearchState state) {
    return {
      SearchFilter.movies: state.result.movies.length,
      SearchFilter.tv: state.result.tvShows.length,
      SearchFilter.people: state.result.people.length,
    };
  }

  List<dynamic> _filteredResults(SearchState state) {
    switch (state.filter) {
      case SearchFilter.movies:
        return state.result.movies;
      case SearchFilter.tv:
        return state.result.tvShows;
      case SearchFilter.people:
        return state.result.people;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchCubit>(),
      child: AppScaffold(
        resizeToAvoidBottomInset: false,
        showBackButton: false,
        appbarSize: 0,
        body: BlocBuilder<SearchCubit, AppState<SearchState>>(
          builder: (context, state) {
            final data = state.data ?? SearchState.initial();

            return Column(
              children: [
                const SizedBox(height: 35),

                SearchField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  hintText: context.locale.search,
                  onChanged: context.read<SearchCubit>().search,
                  keyboardType: TextInputType.text,
                  onClear: () {
                    _searchController.clear();
                    _focusNode.unfocus();
                    context.read<SearchCubit>().clear();
                  },
                ).addPadding(vertical: 25, horizontal: 20),

                SearchFilterChips(
                  selectedFilter: data.filter,
                  onFilterChanged: context.read<SearchCubit>().changeFilter,
                  resultCounts: _resultCounts(data),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: StateHandler(
                    state: state,
                    initialWidget: const SearchEmptyState(),
                    loadingOverlayWidget: Center(
                      child: Loading.loader(context),
                    ),

                    builder: (context, state) {
                      final items = _filteredResults(state.data!);

                      if (items.isEmpty) {
                        return Center(
                          child: AppText(
                            context.locale.noResultsFound,
                            align: TextAlign.center,
                            style: context.textTheme.headlineSmall?.copyWith(
                              color: context.colorScheme.textPrimary,
                              height: 1.2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }

                      return SearchResultsList(
                        items: items,
                        filter: data.filter,
                        onLoadMore: context.read<SearchCubit>().loadMore,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
