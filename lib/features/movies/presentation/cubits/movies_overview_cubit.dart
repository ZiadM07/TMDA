import '../../../../core/constants/exports.dart';
import '../../../../core/state/app_state.dart';
import '../../domain/usecases/get_now_playing.dart';
import '../../domain/usecases/get_popular.dart';
import '../../domain/usecases/get_top_rated.dart';
import '../../domain/entities/movie.dart';

class MoviesOverviewData {
  final List<Movie> nowPlaying;
  final List<Movie> popular;
  final List<Movie> topRated;

  MoviesOverviewData({
    required this.nowPlaying,
    required this.popular,
    required this.topRated,
  });
}

@injectable
class MoviesOverviewCubit extends Cubit<AppState<MoviesOverviewData>> {
  final GetNowPlaying _getNowPlaying;
  final GetPopular _getPopular;
  final GetTopRated _getTopRated;

  MoviesOverviewCubit(this._getNowPlaying, this._getPopular, this._getTopRated)
    : super(const AppState(status: StateStatus.initial));

  Future<void> loadOverview() async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      final futures = await Future.wait([
        _getNowPlaying(page: 1),
        _getPopular(page: 1),
        _getTopRated(page: 1),
      ]);

      final now = (futures[0]).results;
      final pop = (futures[1]).results;
      final top = (futures[2]).results;

      emit(
        state.copyWith(
          status: StateStatus.success,
          data: MoviesOverviewData(
            nowPlaying: now,
            popular: pop,
            topRated: top,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error, message: e.toString()));
    }
  }
}
