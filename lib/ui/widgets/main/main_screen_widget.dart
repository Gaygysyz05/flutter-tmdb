import 'package:flutter/material.dart';
import 'package:themoviedb/domain/data_provider/session_data_provider.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';
import 'package:themoviedb/domain/entity/popular_tv_show_response.dart';
import 'package:themoviedb/domain/entity/tv_show.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/widgets/main/main_screen_model.dart';
import 'package:themoviedb/ui/widgets/media_list/media_list_model.dart';
import 'package:themoviedb/ui/widgets/media_list/media_list_widget.dart';
import 'package:themoviedb/ui/widgets/movie/movie_list_model.dart';
import 'package:themoviedb/ui/widgets/news/news_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show_list/tv_show_list_model.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final movieListModel = MovieListModel();
  final tvListModel = TvShowListModel();

  Widget _buildMediaListTab<T, R>(MediaListModel<T, R> model) {
    return NotifierProvider(
      create: () => model,
      isManagingModel: false,
      child: Builder(
        builder: (context) {
          final watchedModel =
              NotifierProvider.watch<MediaListModel<T, R>>(context);
          if (watchedModel == null) return const SizedBox.shrink();
          return MediaListWidget<T, R>(model: watchedModel);
        },
      ),
    );
  }

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieListModel.setupLocale(context);
    tvListModel.setupLocale(context);
  }

  @override
  void dispose() {
    movieListModel.dispose();
    tvListModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NotifierProvider.read<MainScreenModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TMDB',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () => SessionDataProvider().setSessionId(null),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          const NewsWidget(),
          _buildMediaListTab<Movie, PopularMovieResponse>(movieListModel),
          _buildMediaListTab<TvShow, PopularTvShowResponse>(tvListModel),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.movie), label: 'Movie'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.tv), label: 'TV shows')
          ],
          onTap: onSelectedTab),
    );
  }
}
