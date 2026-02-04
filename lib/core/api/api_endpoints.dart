class ApiEndpoints {
  /// TMDb API v3 Base URL
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'd9b3e15e1633d3d1cf6debe91f80f89c';

  // 🎬 MOVIES
  static const String moviesNowPlaying = '/movie/now_playing';
  static const String moviesPopular = '/movie/popular';
  static const String moviesTopRated = '/movie/top_rated';
  static const String moviesUpcoming = '/movie/upcoming';

  static String movieDetails(int id) => '/movie/$id';
  static String movieCredits(int id) => '/movie/$id/credits';
  static String movieVideos(int id) => '/movie/$id/videos';
  static String movieImages(int id) => '/movie/$id/images';
  static String similarMovies(int id) => '/movie/$id/similar';
  static String movieRecommendations(int id) => '/movie/$id/recommendations';
  static String movieReviews(int id) => '/movie/$id/reviews';

  // 📺 TV SHOWS
  static const String tvAiringToday = '/tv/airing_today';
  static const String tvOnTheAir = '/tv/on_the_air';
  static const String tvPopular = '/tv/popular';
  static const String tvTopRated = '/tv/top_rated';

  static String tvDetails(int id) => '/tv/$id';
  static String tvCredits(int id) => '/tv/$id/credits';
  static String tvVideos(int id) => '/tv/$id/videos';
  static String tvImages(int id) => '/tv/$id/images';
  static String similarTvShows(int id) => '/tv/$id/similar';
  static String tvRecommendations(int id) => '/tv/$id/recommendations';
  static String tvReviews(int id) => '/tv/$id/reviews';

  // 🔍 SEARCH
  static const String searchMovies = '/search/movie';
  static const String searchTv = '/search/tv';
  static const String searchMulti = '/search/multi';

  // 👤 PERSON
  static String personDetails(int id) => '/person/$id';
  static String personCombinedCredits(int id) => '/person/$id/combined_credits';
  static String personImages(int id) => '/person/$id/images';

  // 🧩 GENRES
  static const String movieGenres = '/genre/movie/list';
  static const String tvGenres = '/genre/tv/list';

  // 🔐 AUTH
  static const String createRequestToken = '/authentication/token/new';
  static const String validateWithLogin =
      '/authentication/token/validate_with_login';
  static const String createSession = '/authentication/session/new';

  // 👤 ACCOUNT
  static String watchlistMovies(int accountId) =>
      '/account/$accountId/watchlist/movies';

  static String watchlistTv(int accountId) =>
      '/account/$accountId/watchlist/tv';

  static String updateWatchlist(int accountId) =>
      '/account/$accountId/watchlist';

  static String ratedMovies(int accountId) =>
      '/account/$accountId/rated/movies';

  static String ratedTvShows(int accountId) => '/account/$accountId/rated/tv';
}
