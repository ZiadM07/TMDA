// ignore_for_file: unused_local_variable

import 'package:tmda/features/movies/domain/usecases/get_movie_trailers.dart';
import 'package:tmda/features/movies/domain/entities/movie_video.dart';

import '../../../../core/constants/exports.dart';
import '../../../../core/state/app_state.dart';
import '../../domain/usecases/get_movie_details.dart';
import '../../domain/usecases/get_movie_credits.dart';
import '../../domain/usecases/get_recommendations.dart';
import '../../domain/usecases/get_similar.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/cast_member.dart';
import '../../domain/entities/movie.dart';

@injectable
class MovieDetailsCubit extends Cubit<AppState<MovieDetails>> {
  final GetMovieDetails _getDetails;
  final GetMovieCredits _getCredits;
  final GetRecommendations _getRecommendations;
  final GetSimilar _getSimilar;
  final GetMovieTrailers _getTrailers;

  MovieDetailsCubit(
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
  List<Movie> _recommended = [];
  List<Movie> _similar = [];
  List<MovieVideo> _trailers = [];

  List<CastMember> get credits => _credits;
  List<Movie> get recommended => _recommended;
  List<Movie> get similar => _similar;
  List<MovieVideo> get trailers => _trailers;

  // ===============================
  // LOAD MOVIE
  // ===============================
  Future<void> loadMovie(int movieId) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final details = await _getDetails(movieId);

      // Parallel requests
      final creditsFuture = _getCredits(movieId);
      final recsFuture = _getRecommendations(movieId, page: 1);
      final similarFuture = _getSimilar(movieId, page: 1);
      final trailersFuture = _getTrailers(movieId);

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
