// ignore_for_file: unused_local_variable

import 'package:tmda/features/movies/domain/entities/cast_member.dart';
import 'package:tmda/features/tv/domain/entities/tv_video.dart';
import 'package:tmda/features/tv/domain/usecases/get_tv_trailers.dart';

import '../../../../core/constants/exports.dart';
import '../../../../core/state/app_state.dart';

import '../../domain/entities/tv_details.dart';
import '../../domain/entities/tv_show.dart';

import '../../domain/usecases/get_tv_details.dart';
import '../../domain/usecases/get_tv_credits.dart';
import '../../domain/usecases/get_tv_recommendations.dart';
import '../../domain/usecases/get_tv_similar.dart';

@injectable
class TvDetailsCubit extends Cubit<AppState<TvDetails>> {
  final GetTvDetails _getDetails;
  final GetTvCredits _getCredits;
  final GetTvRecommendations _getRecommendations;
  final GetTvSimilar _getSimilar;
  final GetTvTrailers _getTrailers;
  TvDetailsCubit(
    this._getDetails,
    this._getCredits,
    this._getRecommendations,
    this._getSimilar,
    this._getTrailers,
  ) : super(const AppState());

  // ===============================
  // LOCAL FEATURE STATE (CACHED)
  // ===============================
  List<CastMember> _credits = [];
  List<TvShow> _recommended = [];
  List<TvShow> _similar = [];
  List<TvVideo> _trailers = [];

  List<CastMember> get credits => _credits;
  List<TvShow> get recommended => _recommended;
  List<TvShow> get similar => _similar;
  List<TvVideo> get trailers => _trailers;

  // ===============================
  // LOAD TV SHOW
  // ===============================
  Future<void> loadTv(int tvId) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final details = await _getDetails(tvId);

      // Parallel requests
      final creditsFuture = _getCredits(tvId);
      final recsFuture = _getRecommendations(tvId, page: 1);
      final similarFuture = _getSimilar(tvId, page: 1);
      final trailersFuture = _getTrailers(tvId);

      _credits = await creditsFuture;

      final recs = await recsFuture;
      _recommended = recs.results;

      final similar = await similarFuture;
      _similar = similar.results;

      final trailers = await trailersFuture;
      _trailers = trailers;

      emit(state.copyWith(status: StateStatus.success, data: details));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error, message: e.toString()));
    }
  }
}
