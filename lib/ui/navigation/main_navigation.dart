import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/main/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_widget.dart';

abstract class MainNavigationRoutesNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movies_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRoutesNames.mainScreen
      : MainNavigationRoutesNames.auth;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutesNames.auth: (context) => AuthProvider(
          model: AuthModel(),
          child: AuthWidget(),
        ),
    MainNavigationRoutesNames.mainScreen: (context) => const MainScreenWidget(),
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRoutesNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => MovieDetailsWidget(movieId: movieId),
        );
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
