import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/movie/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 1;

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'TMDB',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: _selectedTab,
          children: [
            Text('Home Page'),
            MovieListWidget(),
            Text('TV shows Page'),
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
