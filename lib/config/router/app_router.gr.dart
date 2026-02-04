// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:tmda/config/router/app_router.dart' as _i2;
import 'package:tmda/core/constants/exports.dart' as _i20;
import 'package:tmda/core/utils/enums.dart' as _i21;
import 'package:tmda/features/actors/presentation/screens/actor_details_screen.dart'
    as _i1;
import 'package:tmda/features/auth/presentation/screens/login_screen.dart'
    as _i3;
import 'package:tmda/features/auth/presentation/screens/signup_screen.dart'
    as _i12;
import 'package:tmda/features/auth/presentation/screens/startup_redirect_screen.dart'
    as _i13;
import 'package:tmda/features/auth/presentation/screens/welcome_screen.dart'
    as _i18;
import 'package:tmda/features/main/main_screen.dart' as _i4;
import 'package:tmda/features/movies/presentation/screens/movies_details_screen.dart'
    as _i5;
import 'package:tmda/features/movies/presentation/screens/movies_screen.dart'
    as _i6;
import 'package:tmda/features/movies/presentation/screens/see_all_movies_screen.dart'
    as _i10;
import 'package:tmda/features/profile/presentation/screens/profile_screen.dart'
    as _i8;
import 'package:tmda/features/search/presentation/screens/search_screen.dart'
    as _i9;
import 'package:tmda/features/shared/presentation/screens/trailer_screen.dart'
    as _i14;
import 'package:tmda/features/tv/presentation/screens/see_all_tv_screen.dart'
    as _i11;
import 'package:tmda/features/tv/presentation/screens/tv_details_screen.dart'
    as _i15;
import 'package:tmda/features/tv/presentation/screens/tv_screen.dart' as _i16;
import 'package:tmda/features/watchlist/presentation/screens/movies_watchlist_screen.dart'
    as _i7;
import 'package:tmda/features/watchlist/presentation/screens/tv_watchlist_screen.dart'
    as _i17;

/// generated route for
/// [_i1.ActorDetailsScreen]
class ActorDetailsRoute extends _i19.PageRouteInfo<ActorDetailsRouteArgs> {
  ActorDetailsRoute({
    _i20.Key? key,
    required int personId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         ActorDetailsRoute.name,
         args: ActorDetailsRouteArgs(key: key, personId: personId),
         initialChildren: children,
       );

  static const String name = 'ActorDetailsRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ActorDetailsRouteArgs>();
      return _i1.ActorDetailsScreen(key: args.key, personId: args.personId);
    },
  );
}

class ActorDetailsRouteArgs {
  const ActorDetailsRouteArgs({this.key, required this.personId});

  final _i20.Key? key;

  final int personId;

  @override
  String toString() {
    return 'ActorDetailsRouteArgs{key: $key, personId: $personId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ActorDetailsRouteArgs) return false;
    return key == other.key && personId == other.personId;
  }

  @override
  int get hashCode => key.hashCode ^ personId.hashCode;
}

/// generated route for
/// [_i2.AuthenticatedRoute]
class AuthenticatedRoutes extends _i19.PageRouteInfo<void> {
  const AuthenticatedRoutes({List<_i19.PageRouteInfo>? children})
    : super(AuthenticatedRoutes.name, initialChildren: children);

  static const String name = 'AuthenticatedRoutes';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i2.AuthenticatedRoute());
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i19.PageRouteInfo<void> {
  const LoginRoute({List<_i19.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginScreen();
    },
  );
}

/// generated route for
/// [_i4.MainScreen]
class MainRoute extends _i19.PageRouteInfo<void> {
  const MainRoute({List<_i19.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainScreen();
    },
  );
}

/// generated route for
/// [_i5.MoviesDetailsScreen]
class MoviesDetailsRoute extends _i19.PageRouteInfo<MoviesDetailsRouteArgs> {
  MoviesDetailsRoute({
    _i20.Key? key,
    required int movieId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         MoviesDetailsRoute.name,
         args: MoviesDetailsRouteArgs(key: key, movieId: movieId),
         initialChildren: children,
       );

  static const String name = 'MoviesDetailsRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MoviesDetailsRouteArgs>();
      return _i5.MoviesDetailsScreen(key: args.key, movieId: args.movieId);
    },
  );
}

class MoviesDetailsRouteArgs {
  const MoviesDetailsRouteArgs({this.key, required this.movieId});

  final _i20.Key? key;

  final int movieId;

  @override
  String toString() {
    return 'MoviesDetailsRouteArgs{key: $key, movieId: $movieId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MoviesDetailsRouteArgs) return false;
    return key == other.key && movieId == other.movieId;
  }

  @override
  int get hashCode => key.hashCode ^ movieId.hashCode;
}

/// generated route for
/// [_i6.MoviesScreen]
class MoviesRoute extends _i19.PageRouteInfo<void> {
  const MoviesRoute({List<_i19.PageRouteInfo>? children})
    : super(MoviesRoute.name, initialChildren: children);

  static const String name = 'MoviesRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i6.MoviesScreen();
    },
  );
}

/// generated route for
/// [_i7.MoviesWatchlistScreen]
class MoviesWatchlistRoute extends _i19.PageRouteInfo<void> {
  const MoviesWatchlistRoute({List<_i19.PageRouteInfo>? children})
    : super(MoviesWatchlistRoute.name, initialChildren: children);

  static const String name = 'MoviesWatchlistRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i7.MoviesWatchlistScreen();
    },
  );
}

/// generated route for
/// [_i8.ProfileScreen]
class ProfileRoute extends _i19.PageRouteInfo<void> {
  const ProfileRoute({List<_i19.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i8.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i9.SearchScreen]
class SearchRoute extends _i19.PageRouteInfo<void> {
  const SearchRoute({List<_i19.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i9.SearchScreen();
    },
  );
}

/// generated route for
/// [_i10.SeeAllMoviesScreen]
class SeeAllMoviesRoute extends _i19.PageRouteInfo<SeeAllMoviesRouteArgs> {
  SeeAllMoviesRoute({
    _i20.Key? key,
    required _i21.MovieCategory category,
    int? movieId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         SeeAllMoviesRoute.name,
         args: SeeAllMoviesRouteArgs(
           key: key,
           category: category,
           movieId: movieId,
         ),
         initialChildren: children,
       );

  static const String name = 'SeeAllMoviesRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SeeAllMoviesRouteArgs>();
      return _i10.SeeAllMoviesScreen(
        key: args.key,
        category: args.category,
        movieId: args.movieId,
      );
    },
  );
}

class SeeAllMoviesRouteArgs {
  const SeeAllMoviesRouteArgs({this.key, required this.category, this.movieId});

  final _i20.Key? key;

  final _i21.MovieCategory category;

  final int? movieId;

  @override
  String toString() {
    return 'SeeAllMoviesRouteArgs{key: $key, category: $category, movieId: $movieId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SeeAllMoviesRouteArgs) return false;
    return key == other.key &&
        category == other.category &&
        movieId == other.movieId;
  }

  @override
  int get hashCode => key.hashCode ^ category.hashCode ^ movieId.hashCode;
}

/// generated route for
/// [_i11.SeeAllTvScreen]
class SeeAllTvRoute extends _i19.PageRouteInfo<SeeAllTvRouteArgs> {
  SeeAllTvRoute({
    _i20.Key? key,
    required _i21.TvCategory category,
    int? tvId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         SeeAllTvRoute.name,
         args: SeeAllTvRouteArgs(key: key, category: category, tvId: tvId),
         initialChildren: children,
       );

  static const String name = 'SeeAllTvRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SeeAllTvRouteArgs>();
      return _i11.SeeAllTvScreen(
        key: args.key,
        category: args.category,
        tvId: args.tvId,
      );
    },
  );
}

class SeeAllTvRouteArgs {
  const SeeAllTvRouteArgs({this.key, required this.category, this.tvId});

  final _i20.Key? key;

  final _i21.TvCategory category;

  final int? tvId;

  @override
  String toString() {
    return 'SeeAllTvRouteArgs{key: $key, category: $category, tvId: $tvId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SeeAllTvRouteArgs) return false;
    return key == other.key && category == other.category && tvId == other.tvId;
  }

  @override
  int get hashCode => key.hashCode ^ category.hashCode ^ tvId.hashCode;
}

/// generated route for
/// [_i12.SignupScreen]
class SignupRoute extends _i19.PageRouteInfo<void> {
  const SignupRoute({List<_i19.PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i12.SignupScreen();
    },
  );
}

/// generated route for
/// [_i13.StartupRedirectScreen]
class StartupRedirectRoute extends _i19.PageRouteInfo<void> {
  const StartupRedirectRoute({List<_i19.PageRouteInfo>? children})
    : super(StartupRedirectRoute.name, initialChildren: children);

  static const String name = 'StartupRedirectRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i13.StartupRedirectScreen();
    },
  );
}

/// generated route for
/// [_i14.TrailerScreen]
class TrailerRoute extends _i19.PageRouteInfo<TrailerRouteArgs> {
  TrailerRoute({
    _i20.Key? key,
    required String youtubeKey,
    String? title,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         TrailerRoute.name,
         args: TrailerRouteArgs(key: key, youtubeKey: youtubeKey, title: title),
         initialChildren: children,
       );

  static const String name = 'TrailerRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TrailerRouteArgs>();
      return _i14.TrailerScreen(
        key: args.key,
        youtubeKey: args.youtubeKey,
        title: args.title,
      );
    },
  );
}

class TrailerRouteArgs {
  const TrailerRouteArgs({this.key, required this.youtubeKey, this.title});

  final _i20.Key? key;

  final String youtubeKey;

  final String? title;

  @override
  String toString() {
    return 'TrailerRouteArgs{key: $key, youtubeKey: $youtubeKey, title: $title}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TrailerRouteArgs) return false;
    return key == other.key &&
        youtubeKey == other.youtubeKey &&
        title == other.title;
  }

  @override
  int get hashCode => key.hashCode ^ youtubeKey.hashCode ^ title.hashCode;
}

/// generated route for
/// [_i15.TvDetailsScreen]
class TvDetailsRoute extends _i19.PageRouteInfo<TvDetailsRouteArgs> {
  TvDetailsRoute({
    _i20.Key? key,
    required int tvId,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         TvDetailsRoute.name,
         args: TvDetailsRouteArgs(key: key, tvId: tvId),
         initialChildren: children,
       );

  static const String name = 'TvDetailsRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TvDetailsRouteArgs>();
      return _i15.TvDetailsScreen(key: args.key, tvId: args.tvId);
    },
  );
}

class TvDetailsRouteArgs {
  const TvDetailsRouteArgs({this.key, required this.tvId});

  final _i20.Key? key;

  final int tvId;

  @override
  String toString() {
    return 'TvDetailsRouteArgs{key: $key, tvId: $tvId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TvDetailsRouteArgs) return false;
    return key == other.key && tvId == other.tvId;
  }

  @override
  int get hashCode => key.hashCode ^ tvId.hashCode;
}

/// generated route for
/// [_i16.TvScreen]
class TvRoute extends _i19.PageRouteInfo<void> {
  const TvRoute({List<_i19.PageRouteInfo>? children})
    : super(TvRoute.name, initialChildren: children);

  static const String name = 'TvRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i16.TvScreen();
    },
  );
}

/// generated route for
/// [_i17.TvWatchlistScreen]
class TvWatchlistRoute extends _i19.PageRouteInfo<void> {
  const TvWatchlistRoute({List<_i19.PageRouteInfo>? children})
    : super(TvWatchlistRoute.name, initialChildren: children);

  static const String name = 'TvWatchlistRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i17.TvWatchlistScreen();
    },
  );
}

/// generated route for
/// [_i2.UnauthenticatedRoute]
class UnauthenticatedRoutes extends _i19.PageRouteInfo<void> {
  const UnauthenticatedRoutes({List<_i19.PageRouteInfo>? children})
    : super(UnauthenticatedRoutes.name, initialChildren: children);

  static const String name = 'UnauthenticatedRoutes';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i2.UnauthenticatedRoute());
    },
  );
}

/// generated route for
/// [_i18.WelcomeScreen]
class WelcomeRoute extends _i19.PageRouteInfo<void> {
  const WelcomeRoute({List<_i19.PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i18.WelcomeScreen();
    },
  );
}
