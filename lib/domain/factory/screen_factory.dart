import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart'
    as old_provider;
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/loader_widget.dart/loader_view_model.dart';
import 'package:themoviedb/ui/widgets/loader_widget.dart/loader_widget.dart';
import 'package:themoviedb/ui/widgets/main/main_screen_model.dart';
import 'package:themoviedb/ui/widgets/main/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_widget.dart';
import 'package:themoviedb/ui/widgets/movie_trailer/movie_trailer_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_model.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_widget.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const AuthWidget(),
    );
  }

  Widget makeMainScreen() {
    return old_provider.NotifierProvider(
      create: () => MainScreenModel(),
      child: const MainScreenWidget(),
    );
  }

  Widget makeMovieDetails(int movieId) {
    return old_provider.NotifierProvider(
      create: () => MovieDetailsModel(movieId),
      child: const MovieDetailsWidget(),
    );
  }

  Widget makeTvShowDetails(int tvShowId) {
    return old_provider.NotifierProvider(
      create: () => TvShowDetailsModel(tvShowId),
      child: const TvShowDetailsWidget(),
    );
  }

  Widget makeMovieTrailer(String youtubeKey) {
    return MovieTrailerWidget(youtubeKey: youtubeKey);
  }
}
