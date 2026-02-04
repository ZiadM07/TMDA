import 'package:tmda/core/state/app_state.dart';
import 'package:tmda/core/state/state_handler.dart';
import 'package:tmda/features/movies/domain/entities/movie_details.dart';
import 'package:tmda/features/movies/presentation/cubits/movie_details_cubit.dart';
import 'package:tmda/features/movies/presentation/widgets/movie_details_sliver_body.dart';
import 'package:tmda/features/movies/presentation/widgets/movie_details_sliver_credits.dart';
import 'package:tmda/features/movies/presentation/widgets/movie_details_sliver_header.dart';
import 'package:tmda/features/movies/presentation/widgets/movie_details_sliver_recommended.dart';
import 'package:tmda/features/movies/presentation/widgets/movie_details_sliver_similar.dart';

import '../../../../core/constants/exports.dart';

@RoutePage()
class MoviesDetailsScreen extends StatelessWidget {
  final int movieId;

  const MoviesDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MovieDetailsCubit>()..loadMovie(movieId),
      child: AppScaffold(
        appbarSize: 0,
        body: BlocBuilder<MovieDetailsCubit, AppState<MovieDetails>>(
          builder: (context, state) {
            return StateHandler(
              state: state,
              builder: (context, state) {
                final movie = state.data!;

                return CustomScrollView(
                  slivers: [
                    MovieDetailsSliverHeader(movie: movie),
                    MovieDetailsSliverBody(movie: movie),
                    const MovieDetailsSliverCredits(),
                    const MovieDetailsSliverRecommended(),
                    const MovieDetailsSliverSimilar(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
