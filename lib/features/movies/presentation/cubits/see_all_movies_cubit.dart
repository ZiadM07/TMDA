import '../../../../core/constants/exports.dart';
import '../../../../core/state/app_state.dart';
import '../../../../core/utils/enums.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/paginated_movies.dart';

import '../../domain/usecases/get_now_playing.dart';
import '../../domain/usecases/get_popular.dart';
import '../../domain/usecases/get_top_rated.dart';
import '../../domain/usecases/get_recommendations.dart';
import '../../domain/usecases/get_similar.dart';

@injectable
class SeeAllMoviesCubit extends Cubit<AppState<SeeAllMoviesState>> {
  final GetNowPlaying _getNowPlaying;
  final GetPopular _getPopular;
  final GetTopRated _getTopRated;
  final GetRecommendations _getRecommendations;
  final GetSimilar _getSimilar;

  late MovieCategory _category;
  int? _movieId;

  SeeAllMoviesCubit(
    this._getNowPlaying,
    this._getPopular,
    this._getTopRated,
    this._getRecommendations,
    this._getSimilar,
  ) : super(
        AppState(
          status: StateStatus.initial,
          data: SeeAllMoviesState.initial(),
        ),
      );

  // ----------------------------
  // INITIAL LOAD
  // ----------------------------
  Future<void> loadInitial(MovieCategory category, {int? movieId}) async {
    _category = category;
    _movieId = movieId;

    emit(
      state.copyWith(
        status: StateStatus.loading,
        data: SeeAllMoviesState.initial(),
      ),
    );

    try {
      final result = await _fetchPage(1);

      emit(
        state.copyWith(
          status: StateStatus.success,
          data: SeeAllMoviesState(
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
  Future<PaginatedMovies> _fetchPage(int page) {
    switch (_category) {
      case MovieCategory.nowPlaying:
        return _getNowPlaying(page: page);

      case MovieCategory.popular:
        return _getPopular(page: page);

      case MovieCategory.topRated:
        return _getTopRated(page: page);

      case MovieCategory.recommended:
        assert(_movieId != null, 'movieId is required for recommended movies');
        return _getRecommendations(_movieId!, page: page);

      case MovieCategory.similar:
        assert(_movieId != null, 'movieId is required for similar movies');
        return _getSimilar(_movieId!, page: page);
    }
  }
}

// ============================
// STATE
// ============================

class SeeAllMoviesState {
  final List<Movie> items;
  final bool isLoadingMore;
  final int page;
  final int totalPages;

  const SeeAllMoviesState({
    required this.items,
    required this.isLoadingMore,
    required this.page,
    required this.totalPages,
  });

  factory SeeAllMoviesState.initial() => const SeeAllMoviesState(
    items: [],
    isLoadingMore: false,
    page: 0,
    totalPages: 1,
  );

  SeeAllMoviesState copyWith({
    List<Movie>? items,
    bool? isLoadingMore,
    int? page,
    int? totalPages,
  }) {
    return SeeAllMoviesState(
      items: items ?? this.items,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
