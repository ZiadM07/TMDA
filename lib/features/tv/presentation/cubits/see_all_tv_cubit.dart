import '../../../../core/constants/exports.dart';
import '../../../../core/state/app_state.dart';
import '../../../../core/utils/enums.dart';

import '../../domain/entities/tv_show.dart';
import '../../domain/entities/paginated_tv.dart';

import '../../domain/usecases/get_airing_today.dart';
import '../../domain/usecases/get_tv_popular.dart';
import '../../domain/usecases/get_tv_top_rated.dart';
import '../../domain/usecases/get_tv_recommendations.dart';
import '../../domain/usecases/get_tv_similar.dart';

@injectable
class SeeAllTvCubit extends Cubit<AppState<SeeAllTvState>> {
  final GetAiringToday _airingToday;
  final GetTvPopular _popular;
  final GetTvTopRated _topRated;
  final GetTvRecommendations _getRecommendations;
  final GetTvSimilar _getSimilar;

  late TvCategory _category;
  int? _tvId;

  SeeAllTvCubit(
    this._airingToday,
    this._popular,
    this._topRated,
    this._getRecommendations,
    this._getSimilar,
  ) : super(
        AppState(status: StateStatus.initial, data: SeeAllTvState.initial()),
      );

  // ----------------------------
  // INITIAL LOAD
  // ----------------------------
  Future<void> loadInitial(TvCategory category, {int? tvId}) async {
    _category = category;
    _tvId = tvId;

    emit(
      state.copyWith(
        status: StateStatus.loading,
        data: SeeAllTvState.initial(),
      ),
    );

    try {
      final result = await _fetchPage(1);

      emit(
        state.copyWith(
          status: StateStatus.success,
          data: SeeAllTvState(
            items: result.results,
            isLoadingMore: false,
            page: result.page,
            totalPages: result.totalPages,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error, message: e.toString()));
    }
  }

  // ----------------------------
  // LOAD MORE (PAGINATION)
  // ----------------------------
  Future<void> loadMore() async {
    final current = state.data!;
    if (current.isLoadingMore || current.page >= current.totalPages) return;

    emit(
      state.copyWith(
        status: StateStatus.loadingOverlay,
        data: current.copyWith(isLoadingMore: true),
      ),
    );

    try {
      final nextPage = current.page + 1;
      final result = await _fetchPage(nextPage);

      emit(
        state.copyWith(
          status: StateStatus.success,
          data: current.copyWith(
            items: [...current.items, ...result.results],
            isLoadingMore: false,
            page: result.page,
            totalPages: result.totalPages,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          message: e.toString(),
          data: current.copyWith(isLoadingMore: false),
        ),
      );
    }
  }

  // ----------------------------
  // INTERNAL FETCH
  // ----------------------------
  Future<PaginatedTv> _fetchPage(int page) {
    switch (_category) {
      case TvCategory.airingToday:
        return _airingToday(page: page);

      case TvCategory.popular:
        return _popular(page: page);

      case TvCategory.topRated:
        return _topRated(page: page);

      case TvCategory.recommended:
        assert(_tvId != null, 'tvId is required for recommended TV shows');
        return _getRecommendations(_tvId!, page: page);

      case TvCategory.similar:
        assert(_tvId != null, 'tvId is required for similar TV shows');
        return _getSimilar(_tvId!, page: page);
    }
  }
}

// ============================
// STATE
// ============================

class SeeAllTvState {
  final List<TvShow> items;
  final bool isLoadingMore;
  final int page;
  final int totalPages;

  const SeeAllTvState({
    required this.items,
    required this.isLoadingMore,
    required this.page,
    required this.totalPages,
  });

  factory SeeAllTvState.initial() => const SeeAllTvState(
    items: [],
    isLoadingMore: false,
    page: 0,
    totalPages: 1,
  );

  SeeAllTvState copyWith({
    List<TvShow>? items,
    bool? isLoadingMore,
    int? page,
    int? totalPages,
  }) {
    return SeeAllTvState(
      items: items ?? this.items,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
