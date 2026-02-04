import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @defaultSystem.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get defaultSystem;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @textIsRequired.
  ///
  /// In en, this message translates to:
  /// **'is required'**
  String get textIsRequired;

  /// No description provided for @textIsTooShort.
  ///
  /// In en, this message translates to:
  /// **'is too short'**
  String get textIsTooShort;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @welcomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Your guide to movies, TV shows, and celebrities'**
  String get welcomeHeadline;

  /// No description provided for @welcomeToOurCommunity.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our\n community'**
  String get welcomeToOurCommunity;

  /// No description provided for @failedToAuthenticate.
  ///
  /// In en, this message translates to:
  /// **'Failed to authenticate: {error}'**
  String failedToAuthenticate(String error);

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get pleaseEnterName;

  /// No description provided for @invalidEgyptianPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid Egyptian phone number. Format: 01XXXXXXXXX'**
  String get invalidEgyptianPhoneNumber;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get userName;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgetPassword;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @newMovies.
  ///
  /// In en, this message translates to:
  /// **'New Movies'**
  String get newMovies;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @casts.
  ///
  /// In en, this message translates to:
  /// **'Casts'**
  String get casts;

  /// No description provided for @allMovies.
  ///
  /// In en, this message translates to:
  /// **'All Movies'**
  String get allMovies;

  /// No description provided for @newSeries.
  ///
  /// In en, this message translates to:
  /// **'New Series'**
  String get newSeries;

  /// No description provided for @seasons.
  ///
  /// In en, this message translates to:
  /// **'Seasons'**
  String get seasons;

  /// No description provided for @episodes.
  ///
  /// In en, this message translates to:
  /// **'Episodes'**
  String get episodes;

  /// No description provided for @allCast.
  ///
  /// In en, this message translates to:
  /// **'All Cast'**
  String get allCast;

  /// No description provided for @allSeries.
  ///
  /// In en, this message translates to:
  /// **'All Series'**
  String get allSeries;

  /// No description provided for @movies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get movies;

  /// No description provided for @series.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get series;

  /// No description provided for @tvShows.
  ///
  /// In en, this message translates to:
  /// **'TV Shows'**
  String get tvShows;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchFailed.
  ///
  /// In en, this message translates to:
  /// **'Search failed'**
  String get searchFailed;

  /// No description provided for @actors.
  ///
  /// In en, this message translates to:
  /// **'Actors'**
  String get actors;

  /// No description provided for @whatYouWantToWatch.
  ///
  /// In en, this message translates to:
  /// **'What do you want to watch?'**
  String get whatYouWantToWatch;

  /// No description provided for @findYourFavoriteMoviesTvShowsAndActors.
  ///
  /// In en, this message translates to:
  /// **'Find your favorite movies, TV shows, and actors.'**
  String get findYourFavoriteMoviesTvShowsAndActors;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @yourMovieRatings.
  ///
  /// In en, this message translates to:
  /// **'Your Movie Ratings'**
  String get yourMovieRatings;

  /// No description provided for @yourTvShowRatings.
  ///
  /// In en, this message translates to:
  /// **'Your TV Show Ratings'**
  String get yourTvShowRatings;

  /// No description provided for @yourActorRatings.
  ///
  /// In en, this message translates to:
  /// **'Your Actor Ratings'**
  String get yourActorRatings;

  /// No description provided for @myWatchList.
  ///
  /// In en, this message translates to:
  /// **'My Watchlist'**
  String get myWatchList;

  /// No description provided for @nowPlaying.
  ///
  /// In en, this message translates to:
  /// **'Now Playing'**
  String get nowPlaying;

  /// No description provided for @popularMovies.
  ///
  /// In en, this message translates to:
  /// **'Popular Movies'**
  String get popularMovies;

  /// No description provided for @topRatedMovies.
  ///
  /// In en, this message translates to:
  /// **'Top Rated Movies'**
  String get topRatedMovies;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @tmdaScore.
  ///
  /// In en, this message translates to:
  /// **'Tmda '**
  String get tmdaScore;

  /// No description provided for @votes.
  ///
  /// In en, this message translates to:
  /// **'Votes'**
  String get votes;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @length.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get length;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minutes;

  /// No description provided for @cast.
  ///
  /// In en, this message translates to:
  /// **'Cast'**
  String get cast;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @similarMovies.
  ///
  /// In en, this message translates to:
  /// **'Similar Movies'**
  String get similarMovies;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'more..'**
  String get readMore;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'less..'**
  String get readLess;

  /// No description provided for @airingToday.
  ///
  /// In en, this message translates to:
  /// **'Airing Today'**
  String get airingToday;

  /// No description provided for @popularShows.
  ///
  /// In en, this message translates to:
  /// **'Popular Shows'**
  String get popularShows;

  /// No description provided for @topRatedShows.
  ///
  /// In en, this message translates to:
  /// **'Top Rated Shows'**
  String get topRatedShows;

  /// No description provided for @similarTvShows.
  ///
  /// In en, this message translates to:
  /// **'Similar Tv Shows'**
  String get similarTvShows;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @placeOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Place of Birth'**
  String get placeOfBirth;

  /// No description provided for @popularity.
  ///
  /// In en, this message translates to:
  /// **'Popularity'**
  String get popularity;

  /// No description provided for @noBiographyAvailable.
  ///
  /// In en, this message translates to:
  /// **'No biography available'**
  String get noBiographyAvailable;

  /// No description provided for @ratedMovies.
  ///
  /// In en, this message translates to:
  /// **'Rated Movies'**
  String get ratedMovies;

  /// No description provided for @ratedTvShows.
  ///
  /// In en, this message translates to:
  /// **'Rated TV Shows'**
  String get ratedTvShows;

  /// No description provided for @signUpDescription.
  ///
  /// In en, this message translates to:
  /// **'TMDB accounts are created on their official website.\nAfter signing up, come back and log in.'**
  String get signUpDescription;

  /// No description provided for @openTmdbWebsite.
  ///
  /// In en, this message translates to:
  /// **'Open TMDB Website'**
  String get openTmdbWebsite;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'I already have an account'**
  String get alreadyHaveAccount;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @areYouSureYouWantToLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areYouSureYouWantToLogout;

  /// No description provided for @notLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Not logged in'**
  String get notLoggedIn;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @noRatedMovies.
  ///
  /// In en, this message translates to:
  /// **'No rated movies yet'**
  String get noRatedMovies;

  /// No description provided for @rateMoviesToSeeThemHere.
  ///
  /// In en, this message translates to:
  /// **'Rate movies to see them here'**
  String get rateMoviesToSeeThemHere;

  /// No description provided for @noRatedTvShows.
  ///
  /// In en, this message translates to:
  /// **'No rated TV shows yet'**
  String get noRatedTvShows;

  /// No description provided for @rateShowsToSeeThemHere.
  ///
  /// In en, this message translates to:
  /// **'Rate TV shows to see them here'**
  String get rateShowsToSeeThemHere;

  /// No description provided for @rateToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Rate To Unlock'**
  String get rateToUnlock;

  /// No description provided for @watchlistMovies.
  ///
  /// In en, this message translates to:
  /// **'Watchlist Movies'**
  String get watchlistMovies;

  /// No description provided for @watchlistTvShows.
  ///
  /// In en, this message translates to:
  /// **'Watchlist TV Shows'**
  String get watchlistTvShows;

  /// No description provided for @addMoviesToWatchlist.
  ///
  /// In en, this message translates to:
  /// **'Add movies to your watchlist to see them here'**
  String get addMoviesToWatchlist;

  /// No description provided for @addShowsToWatchlist.
  ///
  /// In en, this message translates to:
  /// **'Add TV shows to your watchlist to see them here'**
  String get addShowsToWatchlist;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @watchlist.
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get watchlist;

  /// No description provided for @noWatchlist.
  ///
  /// In en, this message translates to:
  /// **'No watchlist yet'**
  String get noWatchlist;

  /// No description provided for @addedToWatchlist.
  ///
  /// In en, this message translates to:
  /// **'Added to watchlist'**
  String get addedToWatchlist;

  /// No description provided for @removedFromWatchlist.
  ///
  /// In en, this message translates to:
  /// **'Removed from watchlist'**
  String get removedFromWatchlist;

  /// No description provided for @loginRequiredToSave.
  ///
  /// In en, this message translates to:
  /// **'Please log in to save movies to your watchlist'**
  String get loginRequiredToSave;

  /// No description provided for @swipeRightToRemove.
  ///
  /// In en, this message translates to:
  /// **'Swipe right to remove from watchlist'**
  String get swipeRightToRemove;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @noTrailerAvailable.
  ///
  /// In en, this message translates to:
  /// **'No trailer available'**
  String get noTrailerAvailable;

  /// No description provided for @noCastAvailable.
  ///
  /// In en, this message translates to:
  /// **'No cast available'**
  String get noCastAvailable;

  /// No description provided for @watchTrailer.
  ///
  /// In en, this message translates to:
  /// **'Watch Trailer'**
  String get watchTrailer;

  /// No description provided for @tapFullscreenForBetterExperience.
  ///
  /// In en, this message translates to:
  /// **'Tap fullscreen for better experience'**
  String get tapFullscreenForBetterExperience;

  /// No description provided for @trailer.
  ///
  /// In en, this message translates to:
  /// **'Trailer'**
  String get trailer;

  /// No description provided for @noTrailerYet.
  ///
  /// In en, this message translates to:
  /// **'This title doesn’t have a trailer yet'**
  String get noTrailerYet;

  /// No description provided for @youMustBeLoggedInToSaveItems.
  ///
  /// In en, this message translates to:
  /// **'You must be logged in to save items'**
  String get youMustBeLoggedInToSaveItems;

  /// No description provided for @enterYourUsername.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get enterYourUsername;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// No description provided for @somethingWentWrongTryAgain.
  ///
  /// In en, this message translates to:
  /// **' Something went wrong. Please try again.'**
  String get somethingWentWrongTryAgain;

  /// No description provided for @youEnteredInvalidUsernameOrPassword.
  ///
  /// In en, this message translates to:
  /// **' You entered invalid username or password'**
  String get youEnteredInvalidUsernameOrPassword;

  /// No description provided for @noResultsFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'No results found. Please try again with different keywords.'**
  String get noResultsFoundDescription;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
