import '../../../../core/constants/exports.dart';
import '../../../../core/state/app_state.dart';
import '../../domain/entities/tv_show.dart';
import '../../domain/usecases/get_airing_today.dart';
import '../../domain/usecases/get_tv_popular.dart';
import '../../domain/usecases/get_tv_top_rated.dart';

class TvOverviewData {
  final List<TvShow> airingToday;
  final List<TvShow> popular;
  final List<TvShow> topRated;

  TvOverviewData({
    required this.airingToday,
    required this.popular,
    required this.topRated,
  });
}

@injectable
class TvOverviewCubit extends Cubit<AppState<TvOverviewData>> {
  final GetAiringToday _airingToday;
  final GetTvPopular _popular;
  final GetTvTopRated _topRated;

  TvOverviewCubit(this._airingToday, this._popular, this._topRated)
    : super(const AppState());

  Future<void> loadOverview() async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final results = await Future.wait([
        _airingToday(page: 1),
        _popular(page: 1),
        _topRated(page: 1),
      ]);

      emit(
        state.copyWith(
          status: StateStatus.success,
          data: TvOverviewData(
            airingToday: results[0].results,
            popular: results[1].results,
            topRated: results[2].results,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error, message: e.toString()));
    }
  }
}
