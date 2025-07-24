import 'package:flutter/material.dart';
import 'package:themoviedb/domain/data_provider/session_data_provider.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/main/main_screen_model.dart';
import 'package:themoviedb/ui/widgets/movie/movie_list_widget.dart';
import 'package:themoviedb/ui/widgets/news/news_widget.dart';
import 'package:themoviedb/ui/widgets/tvshow_list/tv_show_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MainScreenModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'TMDB',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => SessionDataProvider().setSessionId(null),
                icon: Icon(Icons.logout))
          ],
        ),
        body: IndexedStack(
          index: _selectedTab,
          children: [
            NewsWidget(),
            MovieListWidget(),
            TWShowListWidget(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedTab,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movie'),
              BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'TV shows')
            ],
            onTap: onSelectedTab));
  }
}
