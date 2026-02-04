// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:location/location.dart' as _i645;

import '../../features/actors/data/data_sources/actor_remote_data_source.dart'
    as _i925;
import '../../features/actors/data/data_sources/actor_remote_data_source_impl.dart'
    as _i127;
import '../../features/actors/data/repositories/actors_repository_impl.dart'
    as _i927;
import '../../features/actors/domain/repositories/actors_repository.dart'
    as _i839;
import '../../features/actors/domain/usecases/get_actor_credits.dart' as _i158;
import '../../features/actors/domain/usecases/get_actor_details.dart' as _i643;
import '../../features/actors/presentation/cubits/actor_cubit.dart' as _i687;
import '../../features/auth/data/data_sources/auth_local_data_source.dart'
    as _i606;
import '../../features/auth/data/data_sources/auth_local_data_source_impl.dart'
    as _i959;
import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i25;
import '../../features/auth/data/data_sources/auth_remote_data_source_impl.dart'
    as _i182;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/check_session.dart' as _i625;
import '../../features/auth/domain/usecases/create_request_token.dart' as _i329;
import '../../features/auth/domain/usecases/create_session.dart' as _i25;
import '../../features/auth/domain/usecases/logout.dart' as _i597;
import '../../features/auth/domain/usecases/validate_login.dart' as _i600;
import '../../features/auth/presentation/cubits/auth_cubit.dart' as _i521;
import '../../features/auth/presentation/cubits/startup_cubit.dart' as _i156;
import '../../features/movies/data/data_sources/movies_remote_data_source.dart'
    as _i941;
import '../../features/movies/data/data_sources/movies_remote_data_source_impl.dart'
    as _i630;
import '../../features/movies/data/repositories/movies_repository_impl.dart'
    as _i985;
import '../../features/movies/domain/repositories/movies_repository.dart'
    as _i435;
import '../../features/movies/domain/usecases/get_movie_credits.dart' as _i168;
import '../../features/movies/domain/usecases/get_movie_details.dart' as _i79;
import '../../features/movies/domain/usecases/get_movie_trailers.dart' as _i691;
import '../../features/movies/domain/usecases/get_now_playing.dart' as _i53;
import '../../features/movies/domain/usecases/get_popular.dart' as _i373;
import '../../features/movies/domain/usecases/get_recommendations.dart'
    as _i740;
import '../../features/movies/domain/usecases/get_similar.dart' as _i835;
import '../../features/movies/domain/usecases/get_top_rated.dart' as _i532;
import '../../features/movies/presentation/cubits/movie_details_cubit.dart'
    as _i131;
import '../../features/movies/presentation/cubits/movies_overview_cubit.dart'
    as _i740;
import '../../features/movies/presentation/cubits/see_all_movies_cubit.dart'
    as _i825;
import '../../features/profile/data/data_sources/profile_remote_datasource.dart'
    as _i999;
import '../../features/profile/data/data_sources/profile_remote_datasource_impl.dart'
    as _i543;
import '../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i334;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/domain/usecases/get_profile_usecase.dart'
    as _i965;
import '../../features/profile/presentation/cubits/profile_cubit.dart' as _i319;
import '../../features/search/data/data_sources/search_remote_data_source.dart'
    as _i765;
import '../../features/search/data/data_sources/search_remote_data_source_impl.dart'
    as _i892;
import '../../features/search/data/repositories/search_repository_impl.dart'
    as _i1017;
import '../../features/search/domain/repositories/search_repository.dart'
    as _i357;
import '../../features/search/domain/usecases/search_usecase.dart' as _i1053;
import '../../features/search/presentation/cubits/search_cubit.dart' as _i437;
import '../../features/shared/presentation/cubits/app_cubit.dart' as _i1073;
import '../../features/tv/data/data_sources/tv_remote_data_source.dart'
    as _i303;
import '../../features/tv/data/data_sources/tv_remote_data_source_impl.dart'
    as _i363;
import '../../features/tv/data/repositories/tv_repository_impl.dart' as _i993;
import '../../features/tv/domain/repositories/tv_repository.dart' as _i388;
import '../../features/tv/domain/usecases/get_airing_today.dart' as _i1045;
import '../../features/tv/domain/usecases/get_tv_credits.dart' as _i1006;
import '../../features/tv/domain/usecases/get_tv_details.dart' as _i861;
import '../../features/tv/domain/usecases/get_tv_popular.dart' as _i333;
import '../../features/tv/domain/usecases/get_tv_recommendations.dart' as _i249;
import '../../features/tv/domain/usecases/get_tv_similar.dart' as _i566;
import '../../features/tv/domain/usecases/get_tv_top_rated.dart' as _i1011;
import '../../features/tv/domain/usecases/get_tv_trailers.dart' as _i405;
import '../../features/tv/presentation/cubits/see_all_tv_cubit.dart' as _i540;
import '../../features/tv/presentation/cubits/tv_details_cubit.dart' as _i1054;
import '../../features/tv/presentation/cubits/tv_overview_cubit.dart' as _i871;
import '../../features/watchlist/data/data_sources/watchlist_remote_datasource.dart'
    as _i318;
import '../../features/watchlist/data/data_sources/watchlist_remote_datasource_impl.dart'
    as _i718;
import '../../features/watchlist/data/repositories/watchlist_repository_impl.dart'
    as _i967;
import '../../features/watchlist/domain/repositories/watchlist_repository.dart'
    as _i974;
import '../../features/watchlist/domain/usecases/add_to_watchlist.dart'
    as _i1061;
import '../../features/watchlist/domain/usecases/get_watchlist_movies.dart'
    as _i54;
import '../../features/watchlist/domain/usecases/get_watchlist_tv.dart'
    as _i993;
import '../../features/watchlist/domain/usecases/remove_from_watchlist.dart'
    as _i1009;
import '../../features/watchlist/presentation/cubits/watchlist_cubit.dart'
    as _i774;
import '../api/api_client.dart' as _i277;
import '../constants/exports.dart' as _i600;
import '../framework/network.dart' as _i159;
import '../framework/permissions.dart' as _i349;
import 'injectable.dart' as _i1027;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectionModule = _$InjectionModule();
    gh.factory<_i645.Location>(() => injectionModule.location);
    await gh.factoryAsync<_i600.SharedPreferences>(
      () => injectionModule.providePrefs(),
      preResolve: true,
    );
    gh.lazySingleton<_i600.InternetConnection>(
      () => injectionModule.internetConnection(),
    );
    gh.lazySingleton<_i600.Dio>(() => injectionModule.dio());
    gh.lazySingleton<_i600.StorageService>(
      () => injectionModule.storageService(gh<_i600.SharedPreferences>()),
    );
    gh.factory<_i159.NetworkInfo>(
      () => _i159.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.lazySingleton<_i349.Permissions>(
      () => _i349.PermissionsInfo(location: gh<_i645.Location>()),
    );
    gh.lazySingleton<_i600.AppPreferences>(
      () => injectionModule.appPreferences(gh<_i600.StorageService>()),
    );
    gh.lazySingleton<_i606.AuthLocalDataSource>(
      () => _i959.AuthLocalDataSourceImpl(gh<_i600.AppPreferences>()),
    );
    gh.singleton<_i600.AppRouter>(
      () => injectionModule.router(gh<_i600.AppPreferences>()),
    );
    gh.singleton<_i1073.AppCubit>(
      () => _i1073.AppCubit(gh<_i600.AppPreferences>()),
    );
    gh.lazySingleton<_i277.ApiClient>(
      () => injectionModule.apiClient(
        gh<_i600.Dio>(),
        gh<_i600.AppPreferences>(),
      ),
    );
    gh.lazySingleton<_i999.ProfileRemoteDataSource>(
      () => _i543.ProfileRemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i925.ActorRemoteDataSource>(
      () => _i127.ActorRemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i318.WatchlistRemoteDataSource>(
      () => _i718.WatchlistRemoteDataSourceImpl(
        gh<_i277.ApiClient>(),
        gh<_i600.AppPreferences>(),
      ),
    );
    gh.lazySingleton<_i941.MoviesRemoteDataSource>(
      () => _i630.MoviesRemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i435.MoviesRepository>(
      () => _i985.MoviesRepositoryImpl(gh<_i941.MoviesRemoteDataSource>()),
    );
    gh.lazySingleton<_i894.ProfileRepository>(
      () => _i334.ProfileRepositoryImpl(gh<_i999.ProfileRemoteDataSource>()),
    );
    gh.lazySingleton<_i839.ActorRepository>(
      () => _i927.ActorRepositoryImpl(gh<_i925.ActorRemoteDataSource>()),
    );
    gh.lazySingleton<_i25.AuthRemoteDataSource>(
      () => _i182.AuthRemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i765.SearchRemoteDataSource>(
      () => _i892.SearchRemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i303.TvRemoteDataSource>(
      () => _i363.TvRemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i974.WatchlistRepository>(
      () =>
          _i967.WatchlistRepositoryImpl(gh<_i318.WatchlistRemoteDataSource>()),
    );
    gh.lazySingleton<_i388.TvRepository>(
      () => _i993.TvRepositoryImpl(gh<_i303.TvRemoteDataSource>()),
    );
    gh.factory<_i168.GetMovieCredits>(
      () => _i168.GetMovieCredits(gh<_i435.MoviesRepository>()),
    );
    gh.factory<_i79.GetMovieDetails>(
      () => _i79.GetMovieDetails(gh<_i435.MoviesRepository>()),
    );
    gh.factory<_i691.GetMovieTrailers>(
      () => _i691.GetMovieTrailers(gh<_i435.MoviesRepository>()),
    );
    gh.factory<_i53.GetNowPlaying>(
      () => _i53.GetNowPlaying(gh<_i435.MoviesRepository>()),
    );
    gh.factory<_i373.GetPopular>(
      () => _i373.GetPopular(gh<_i435.MoviesRepository>()),
    );
    gh.factory<_i740.GetRecommendations>(
      () => _i740.GetRecommendations(gh<_i435.MoviesRepository>()),
    );
    gh.factory<_i835.GetSimilar>(
      () => _i835.GetSimilar(gh<_i435.MoviesRepository>()),
    );
    gh.factory<_i532.GetTopRated>(
      () => _i532.GetTopRated(gh<_i435.MoviesRepository>()),
    );
    gh.lazySingleton<_i357.SearchRepository>(
      () => _i1017.SearchRepositoryImpl(gh<_i765.SearchRemoteDataSource>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i25.AuthRemoteDataSource>(),
        gh<_i606.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i625.CheckSession>(
      () => _i625.CheckSession(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i329.CreateRequestToken>(
      () => _i329.CreateRequestToken(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i25.CreateSession>(
      () => _i25.CreateSession(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i597.Logout>(() => _i597.Logout(gh<_i787.AuthRepository>()));
    gh.factory<_i600.ValidateLogin>(
      () => _i600.ValidateLogin(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i1045.GetAiringToday>(
      () => _i1045.GetAiringToday(gh<_i388.TvRepository>()),
    );
    gh.factory<_i1006.GetTvCredits>(
      () => _i1006.GetTvCredits(gh<_i388.TvRepository>()),
    );
    gh.factory<_i861.GetTvDetails>(
      () => _i861.GetTvDetails(gh<_i388.TvRepository>()),
    );
    gh.factory<_i333.GetTvPopular>(
      () => _i333.GetTvPopular(gh<_i388.TvRepository>()),
    );
    gh.factory<_i249.GetTvRecommendations>(
      () => _i249.GetTvRecommendations(gh<_i388.TvRepository>()),
    );
    gh.factory<_i566.GetTvSimilar>(
      () => _i566.GetTvSimilar(gh<_i388.TvRepository>()),
    );
    gh.factory<_i1011.GetTvTopRated>(
      () => _i1011.GetTvTopRated(gh<_i388.TvRepository>()),
    );
    gh.factory<_i405.GetTvTrailers>(
      () => _i405.GetTvTrailers(gh<_i388.TvRepository>()),
    );
    gh.factory<_i131.MovieDetailsCubit>(
      () => _i131.MovieDetailsCubit(
        gh<_i79.GetMovieDetails>(),
        gh<_i168.GetMovieCredits>(),
        gh<_i740.GetRecommendations>(),
        gh<_i835.GetSimilar>(),
        gh<_i691.GetMovieTrailers>(),
      ),
    );
    gh.factory<_i965.GetProfileUsecase>(
      () => _i965.GetProfileUsecase(gh<_i894.ProfileRepository>()),
    );
    gh.factory<_i158.GetActorCredits>(
      () => _i158.GetActorCredits(gh<_i839.ActorRepository>()),
    );
    gh.factory<_i643.GetActorDetails>(
      () => _i643.GetActorDetails(gh<_i839.ActorRepository>()),
    );
    gh.factory<_i1053.SearchUsecase>(
      () => _i1053.SearchUsecase(gh<_i357.SearchRepository>()),
    );
    gh.factory<_i740.MoviesOverviewCubit>(
      () => _i740.MoviesOverviewCubit(
        gh<_i53.GetNowPlaying>(),
        gh<_i373.GetPopular>(),
        gh<_i532.GetTopRated>(),
      ),
    );
    gh.factory<_i437.SearchCubit>(
      () => _i437.SearchCubit(gh<_i1053.SearchUsecase>()),
    );
    gh.factory<_i1061.AddToWatchlist>(
      () => _i1061.AddToWatchlist(gh<_i974.WatchlistRepository>()),
    );
    gh.factory<_i54.GetWatchlistMovies>(
      () => _i54.GetWatchlistMovies(gh<_i974.WatchlistRepository>()),
    );
    gh.factory<_i993.GetWatchlistTv>(
      () => _i993.GetWatchlistTv(gh<_i974.WatchlistRepository>()),
    );
    gh.factory<_i1009.RemoveFromWatchlist>(
      () => _i1009.RemoveFromWatchlist(gh<_i974.WatchlistRepository>()),
    );
    gh.factory<_i871.TvOverviewCubit>(
      () => _i871.TvOverviewCubit(
        gh<_i1045.GetAiringToday>(),
        gh<_i333.GetTvPopular>(),
        gh<_i1011.GetTvTopRated>(),
      ),
    );
    gh.factory<_i156.StartupCubit>(
      () => _i156.StartupCubit(gh<_i625.CheckSession>()),
    );
    gh.factory<_i540.SeeAllTvCubit>(
      () => _i540.SeeAllTvCubit(
        gh<_i1045.GetAiringToday>(),
        gh<_i333.GetTvPopular>(),
        gh<_i1011.GetTvTopRated>(),
        gh<_i249.GetTvRecommendations>(),
        gh<_i566.GetTvSimilar>(),
      ),
    );
    gh.factory<_i319.ProfileCubit>(
      () => _i319.ProfileCubit(gh<_i965.GetProfileUsecase>()),
    );
    gh.factory<_i521.AuthCubit>(
      () => _i521.AuthCubit(
        gh<_i329.CreateRequestToken>(),
        gh<_i600.ValidateLogin>(),
        gh<_i25.CreateSession>(),
        gh<_i597.Logout>(),
      ),
    );
    gh.factory<_i774.WatchlistCubit>(
      () => _i774.WatchlistCubit(
        gh<_i54.GetWatchlistMovies>(),
        gh<_i993.GetWatchlistTv>(),
        gh<_i1061.AddToWatchlist>(),
        gh<_i1009.RemoveFromWatchlist>(),
      ),
    );
    gh.factory<_i825.SeeAllMoviesCubit>(
      () => _i825.SeeAllMoviesCubit(
        gh<_i53.GetNowPlaying>(),
        gh<_i373.GetPopular>(),
        gh<_i532.GetTopRated>(),
        gh<_i740.GetRecommendations>(),
        gh<_i835.GetSimilar>(),
      ),
    );
    gh.factory<_i1054.TvDetailsCubit>(
      () => _i1054.TvDetailsCubit(
        gh<_i861.GetTvDetails>(),
        gh<_i1006.GetTvCredits>(),
        gh<_i249.GetTvRecommendations>(),
        gh<_i566.GetTvSimilar>(),
        gh<_i405.GetTvTrailers>(),
      ),
    );
    gh.factory<_i687.ActorDetailsCubit>(
      () => _i687.ActorDetailsCubit(
        gh<_i643.GetActorDetails>(),
        gh<_i158.GetActorCredits>(),
      ),
    );
    return this;
  }
}

class _$InjectionModule extends _i1027.InjectionModule {}
