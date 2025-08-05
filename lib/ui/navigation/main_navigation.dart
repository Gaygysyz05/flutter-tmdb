import 'package:flutter/material.dart';
import 'package:themoviedb/domain/factory/screen_factory.dart';

abstract class MainNavigationRoutesNames {
  static const loaderWidget = '/';
  static const auth = '/auth';
  static const mainScreen = '/main_screen';
  static const movieDetails = '/main_screen/movies_details';
  static const tvShowDetails = '/main_screen/tv_show_details';
  static const movieTrailer = '/main_screen/movies_details/trailer';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutesNames.loaderWidget: (_) => _screenFactory.makeLoader(),
    MainNavigationRoutesNames.auth: (_) => _screenFactory.makeAuth(),
    MainNavigationRoutesNames.mainScreen: (_) => _screenFactory.makeMainScreen()
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRoutesNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeMovieDetails(movieId),
        );
      case MainNavigationRoutesNames.tvShowDetails:
        final arguments = settings.arguments;
        final tvShowId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeTvShowDetails(tvShowId),
        );
      case MainNavigationRoutesNames.movieTrailer:
        final arguments = settings.arguments;
        final youtubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeMovieTrailer(youtubeKey),
        );
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        MainNavigationRoutesNames.loaderWidget, (route) => false);
  }
}
