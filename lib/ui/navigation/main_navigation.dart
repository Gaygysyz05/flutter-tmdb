import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/main/main_screen_model.dart';
import 'package:themoviedb/ui/widgets/main/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_widget.dart';
import 'package:themoviedb/ui/widgets/movie_trailer/movie_trailer_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_model.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_widget.dart';

abstract class MainNavigationRoutesNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movies_details';
  static const tvShowDetails = '/tv_show_details';
  static const movieTrailer = '/movies_details/trailer';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRoutesNames.mainScreen
      : MainNavigationRoutesNames.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutesNames.auth: (context) => NotifierProvider(
          create: () => AuthModel(),
          child: const AuthWidget(),
        ),
    MainNavigationRoutesNames.mainScreen: (context) => NotifierProvider(
          create: () => MainScreenModel(),
          child: const MainScreenWidget(),
        ),
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRoutesNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            create: () => MovieDetailsModel(movieId),
            child: const MovieDetailsWidget(),
          ),
        );
      case MainNavigationRoutesNames.tvShowDetails:
        final arguments = settings.arguments;
        final tvShowId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            create: () => TvShowDetailsModel(tvShowId),
            child: const TvShowDetailsWidget(),
          ),
        );
      case MainNavigationRoutesNames.movieTrailer:
      final arguments = settings.arguments;
      final youtubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (context) => MovieTrailerWidget(youtubeKey: youtubeKey),
        );
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
